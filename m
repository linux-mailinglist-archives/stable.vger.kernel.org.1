Return-Path: <stable+bounces-61129-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 66A3593A6FF
	for <lists+stable@lfdr.de>; Tue, 23 Jul 2024 20:41:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 231B4283E2A
	for <lists+stable@lfdr.de>; Tue, 23 Jul 2024 18:41:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84FF315884E;
	Tue, 23 Jul 2024 18:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NLJrkZ4n"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4122C13D896;
	Tue, 23 Jul 2024 18:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721760060; cv=none; b=WURLGjAp8m0Q697g4t68AlOfpsxkHR/WNrOoRA8sJ0TaT5giXIviz0WAZjmF7ovufEddMPGFtCMz0m9YRymGyqZeAI7d/AgfGwpm8otK+uKJsVaB35rGqpha30rWKCH4+L+EX/FaNtJLRXCDqzl5Jha3NVmb5PlMzXnDVTF+aW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721760060; c=relaxed/simple;
	bh=DObRVz8uT/a8hro1codjtSqfa+iJNj1IzaoC0Qdojj0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a7YlCHjKsWO9Z1w/ypypEmvf5YdH5J1qCDJ1PekY81c7QFqur8pVEKQY8Qge6Lyx5KEYq19CWP4VRfTNAurnbzMlHV8hjuCmOur1bjkXxH8GhAc4IAwudtEgykMlX/lK9ryOMgyuT5YbUbNm9chzKy6mzqRCgSA4bTFUOjHHJpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NLJrkZ4n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61D08C4AF0A;
	Tue, 23 Jul 2024 18:40:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1721760059;
	bh=DObRVz8uT/a8hro1codjtSqfa+iJNj1IzaoC0Qdojj0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NLJrkZ4nWq/Zgr/PC6oaV8upho6Y6ReM3TCkGWx5qw7sq/V2bCw2xo4DX+0+0/Rov
	 4UP/9qNclmuzX00F2JsxHyWR2qu53Ay4ad5XurQzO07BjyCo8O0jBJegmk0OUSleKG
	 poGdRMcjV8MfUNKNyWbhAGgDpxNTOXhwEGJ/jU0o=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jack Yu <jack.yu@realtek.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.9 089/163] ASoC: rt722-sdca-sdw: add silence detection register as volatile
Date: Tue, 23 Jul 2024 20:23:38 +0200
Message-ID: <20240723180146.915437970@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240723180143.461739294@linuxfoundation.org>
References: <20240723180143.461739294@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jack Yu <jack.yu@realtek.com>

[ Upstream commit 968c974c08106fcf911d8d390d0f049af855d348 ]

Including silence detection register as volatile.

Signed-off-by: Jack Yu <jack.yu@realtek.com>
Link: https://msgid.link/r/c66a6bd6d220426793096b42baf85437@realtek.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/rt722-sdca-sdw.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/codecs/rt722-sdca-sdw.c b/sound/soc/codecs/rt722-sdca-sdw.c
index 65d584c1886e8..0a14198f8a424 100644
--- a/sound/soc/codecs/rt722-sdca-sdw.c
+++ b/sound/soc/codecs/rt722-sdca-sdw.c
@@ -68,6 +68,7 @@ static bool rt722_sdca_mbq_readable_register(struct device *dev, unsigned int re
 	case 0x200007f:
 	case 0x2000082 ... 0x200008e:
 	case 0x2000090 ... 0x2000094:
+	case 0x3110000:
 	case 0x5300000 ... 0x5300002:
 	case 0x5400002:
 	case 0x5600000 ... 0x5600007:
@@ -125,6 +126,7 @@ static bool rt722_sdca_mbq_volatile_register(struct device *dev, unsigned int re
 	case 0x2000067:
 	case 0x2000084:
 	case 0x2000086:
+	case 0x3110000:
 		return true;
 	default:
 		return false;
-- 
2.43.0




