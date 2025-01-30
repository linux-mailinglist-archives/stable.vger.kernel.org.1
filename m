Return-Path: <stable+bounces-111501-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8604A22F74
	for <lists+stable@lfdr.de>; Thu, 30 Jan 2025 15:22:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1BF413A87E3
	for <lists+stable@lfdr.de>; Thu, 30 Jan 2025 14:21:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B7161E8855;
	Thu, 30 Jan 2025 14:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PCuxJ8aI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF6661BDA95;
	Thu, 30 Jan 2025 14:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738246919; cv=none; b=A9rYMPy+g1xxidATmsBuQNQE6dzZa3zPk9CUkB3yXjN8k+wf0KkWDqhnj8clVW7wM57eltYcqGj1bjW61gno+XhSFAiZWMpEnNsIhrtmCqFJY3oprv3YFenjDLZgC59nmlaEhpNtfzkmJ/z3e1anBwV7NGhkjOs+Q5NGFK4CI+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738246919; c=relaxed/simple;
	bh=xIZkGa3AeX2K6PH4nR9yio0+JqHQc8iDfqFBI+M1+bI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Yqh0bTA/NmXOGXEC+BC8cs5ML/AQmm9BnyIlFBZza75F9ywQMkvG04dW84YwtJDmOxbKiqNfhqAP/Uy7Zr/8Al9FDTOpH9XT200DczZ1Q8WqOALCV4k2n7ILGM2ZwKB08Ts+4sEzfR6DawR96PdB+8E4tCHFeeLuR+tdMJ73WqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PCuxJ8aI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59573C4CED2;
	Thu, 30 Jan 2025 14:21:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1738246919;
	bh=xIZkGa3AeX2K6PH4nR9yio0+JqHQc8iDfqFBI+M1+bI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PCuxJ8aISeuQGwbCh7y+RZlF5w0H/Ax13p1sOTZERHzJY05JuIbOHrKu1efTeKgpD
	 W0MU+p5mbtV4CWmMMBWcQNt2lb+h+utZkhPpdsQsS4pnpUq/icdDOJ9D/xWTLx5itH
	 laQbAe/Si0D0vJFQgZDOQqIT7k0k7yEmCXaQzzuY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Mikulas Patocka <mpatocka@redhat.com>
Subject: [PATCH 5.10 020/133] dm-ebs: dont set the flag DM_TARGET_PASSES_INTEGRITY
Date: Thu, 30 Jan 2025 15:00:09 +0100
Message-ID: <20250130140143.319019519@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250130140142.491490528@linuxfoundation.org>
References: <20250130140142.491490528@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mikulas Patocka <mpatocka@redhat.com>

commit 47f33c27fc9565fb0bc7dfb76be08d445cd3d236 upstream.

dm-ebs uses dm-bufio to process requests that are not aligned on logical
sector size. dm-bufio doesn't support passing integrity data (and it is
unclear how should it do it), so we shouldn't set the
DM_TARGET_PASSES_INTEGRITY flag.

Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
Cc: stable@vger.kernel.org
Fixes: d3c7b35c20d6 ("dm: add emulated block size target")
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/md/dm-ebs-target.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/md/dm-ebs-target.c
+++ b/drivers/md/dm-ebs-target.c
@@ -437,7 +437,7 @@ static int ebs_iterate_devices(struct dm
 static struct target_type ebs_target = {
 	.name		 = "ebs",
 	.version	 = {1, 0, 1},
-	.features	 = DM_TARGET_PASSES_INTEGRITY,
+	.features	 = 0,
 	.module		 = THIS_MODULE,
 	.ctr		 = ebs_ctr,
 	.dtr		 = ebs_dtr,



