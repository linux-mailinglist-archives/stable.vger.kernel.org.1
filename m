Return-Path: <stable+bounces-167959-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CE251B232BF
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 20:21:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A90036E3A9A
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 18:16:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D99181D416C;
	Tue, 12 Aug 2025 18:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CkENKph0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99AA71B87F2;
	Tue, 12 Aug 2025 18:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755022569; cv=none; b=R2T1RMjGL/H4dm8eystu+DdwKCdVn6NgwsnM5pLeq1JWRONR7QCMzB5AfsiZIXHZbitzT7Pl+rCO1PjiVaQlLYWmaYjPlwrjFbz7dchtrvzKCMngOxy26t3oD/GnKBOLEokPMTrnz/4a1bSxK8X1cNY8KF4j2p8vVoB2b/vC2Hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755022569; c=relaxed/simple;
	bh=cgwxmKbDbbBdDikd7wQ/wR4KyMtZl8YLYfQ5IJl77Vo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QVKt6lf1Uu8z7iYjtxVD/t6H+x8+KrwrRcDXY5oUXMVaHT7eEAIMJPBZVK0jeCu8OBRIz2/rx+t0hbjy/k40anHnE+yxIIw+GwJnKYg15QipSF7eElWJ50XKIbJFjwykjdyArfZReCucgx3s3DoruOOOF0DCuaZq+UilvOo2yJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CkENKph0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2D0BC4CEF1;
	Tue, 12 Aug 2025 18:16:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755022569;
	bh=cgwxmKbDbbBdDikd7wQ/wR4KyMtZl8YLYfQ5IJl77Vo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CkENKph0PUOXyYzowLlIshjH651xCtaJT21fUwZe9O3NvK9FfCJj5+aiCI6I1PyQZ
	 REuB6lAu/eWZkV0mNmqukjga4d2R7BngFGzVwDkotKPbGZyK0n5C8Y2ZTg6dN52i53
	 SlAO7PcyNTsBjVqgTyBLN7mkEpdvhMMr7wcwfF6A=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ian Rogers <irogers@google.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 176/369] perf dso: Add missed dso__put to dso__load_kcore
Date: Tue, 12 Aug 2025 19:27:53 +0200
Message-ID: <20250812173021.398175546@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250812173014.736537091@linuxfoundation.org>
References: <20250812173014.736537091@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ian Rogers <irogers@google.com>

[ Upstream commit 63a088e999de3f431f87d9a367933da894ddb613 ]

The kcore loading creates a set of list nodes that have reference
counted references to maps of the kcore. The list node freeing in the
success path wasn't releasing the maps, add the missing puts. It is
unclear why this leak was being missed by leak sanitizer.

Fixes: 83720209961f ("perf map: Move map list node into symbol")
Signed-off-by: Ian Rogers <irogers@google.com>
Link: https://lore.kernel.org/r/20250624190326.2038704-2-irogers@google.com
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/perf/util/symbol.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index 3bbf173ad822..c0ec5ed4f1aa 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -1405,6 +1405,7 @@ static int dso__load_kcore(struct dso *dso, struct map *map,
 				goto out_err;
 			}
 		}
+		map__zput(new_node->map);
 		free(new_node);
 	}
 
-- 
2.39.5




