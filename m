Return-Path: <stable+bounces-120713-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 87AF3A507FD
	for <lists+stable@lfdr.de>; Wed,  5 Mar 2025 19:03:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A2E43B00ED
	for <lists+stable@lfdr.de>; Wed,  5 Mar 2025 18:02:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 241D5250BFC;
	Wed,  5 Mar 2025 18:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LcyNLGbO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C17C120C004;
	Wed,  5 Mar 2025 18:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741197756; cv=none; b=SJ9fNDtsW6xBrehkKBmUC3PVkv79ucAUB1/50h+Gk+iteEhkLC2PG+hHshYRnoDmZkilzQLykJD2e3P73oThS+JNEFG3f1TZeMwfmaPoRG8vPw/e8+IfUDuzGOTv7seTFZWIwSwcw9NK74kQFeIaExtlSeOLubfCRVwBD3QuR2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741197756; c=relaxed/simple;
	bh=P0fzaIEz7l5MrUTFfJINgUaCvJsBR65G/YLWXpfGggM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JBtvsxnrE3UBFWilEgBv5HYnFxSKicCSdiHJ0sRGedIaaW8llaIymT9FgFmytTFdH0swOK3vRTP91uv9tlFve6d/Xrz5YNF1UH0rV5yNjKvTH3bm+OjiRH0POnAJuERvc1br+1nuonFIPwlB3HzcsVT3Zvmb19UZiUZVac493Dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LcyNLGbO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47936C4CED1;
	Wed,  5 Mar 2025 18:02:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741197756;
	bh=P0fzaIEz7l5MrUTFfJINgUaCvJsBR65G/YLWXpfGggM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LcyNLGbOV4WnJFPhYVcVjjkMNy2FfnAbd2CO0TJvEwwDVLTy9Vu1HLWz7ytd45RYV
	 WsZypifiyhMEwleDSd2VWnI3Jij9vmD3yZdqbLbZNw3FNpI1M9SGdOkkA+/m0gJ0qB
	 qho8kj9l6ftWK5NAsCIAMclvZQsdnMpOT/Ht4x4M=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Tomas Glozar <tglozar@redhat.com>
Subject: [PATCH 6.6 089/142] Revert "rtla/timerlat_top: Set OSNOISE_WORKLOAD for kernel threads"
Date: Wed,  5 Mar 2025 18:48:28 +0100
Message-ID: <20250305174503.909373226@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250305174500.327985489@linuxfoundation.org>
References: <20250305174500.327985489@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tomas Glozar <tglozar@redhat.com>

This reverts commit 41955b6c268154f81e34f9b61cf8156eec0730c0.

The commit breaks rtla build, since params->kernel_workload is not
present on 6.6-stable.

Signed-off-by: Tomas Glozar <tglozar@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/tracing/rtla/src/timerlat_top.c |   15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

--- a/tools/tracing/rtla/src/timerlat_top.c
+++ b/tools/tracing/rtla/src/timerlat_top.c
@@ -679,15 +679,12 @@ timerlat_top_apply_config(struct osnoise
 		auto_house_keeping(&params->monitored_cpus);
 	}
 
-	/*
-	* Set workload according to type of thread if the kernel supports it.
-	* On kernels without support, user threads will have already failed
-	* on missing timerlat_fd, and kernel threads do not need it.
-	*/
-	retval = osnoise_set_workload(top->context, params->kernel_workload);
-	if (retval < -1) {
-		err_msg("Failed to set OSNOISE_WORKLOAD option\n");
-		goto out_err;
+	if (params->user_top) {
+		retval = osnoise_set_workload(top->context, 0);
+		if (retval) {
+			err_msg("Failed to set OSNOISE_WORKLOAD option\n");
+			goto out_err;
+		}
 	}
 
 	return 0;



