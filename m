Return-Path: <stable+bounces-261490-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 8/wLGPxKJWopGQIAu9opvQ
	(envelope-from <stable+bounces-261490-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 07 Jun 2026 12:42:04 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E112F64FEC1
	for <lists+stable@lfdr.de>; Sun, 07 Jun 2026 12:42:03 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=aEbKxkKo;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-261490-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-261490-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D3726304BD90
	for <lists+stable@lfdr.de>; Sun,  7 Jun 2026 10:39:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AEC23254A9;
	Sun,  7 Jun 2026 10:39:16 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21E142D3A69;
	Sun,  7 Jun 2026 10:39:15 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780828756; cv=none; b=s0mzu6WGSKP4VjdtMhshu61u3wG7FpH6srx4gelwNc/r4kTZFWUH6huekkLwwA6qwKcHe9CHK6IKp8ShzdTUJqhPDU1kkr45twoSN5k/gbhZpJrZoGHjf33iyvhBujJGHVf2tJjpCSastHSFDiGsEXpwBLTBW5U7zDW1KFkqqAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780828756; c=relaxed/simple;
	bh=TYE+JzgUDXHVu297slq13MdduVNxtWMO+pddTObSxLQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VO9YOH7IFdXWnkQe1TI6d/2pebFpkrMe61Wy+U1LzNGkAou5f0QISoS2EsvNpNEfFhQfSJDivx0nkHS5rEgSRkGhf8FBt9owXxKIZhaM6ooPJWJB2AKYXUCrq24sA0gLg3zbbCKTwhZZ7uTovFtWaSIRtWpe4jJehcn7ipUQp1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=aEbKxkKo; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EDE71F00893;
	Sun,  7 Jun 2026 10:39:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780828755;
	bh=Xa5PdS3ZO1/wHrGUI1fYX5O39Kv/QBneSTmgyj/1Ptc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=aEbKxkKoNXb3XYEa97Ym4ukOKc/3R+nL+EchpKHfF5UnjXgTblh/miE1+iERj07vX
	 ImbCevlx/3jByqTBQVGfp9UKH0Jup94RQ7Sx0SDtTeqV//kSWnPkIcFODyH9XCJqTZ
	 hyTfO1yNkotzs65L6S8R9trNruTuKBDN7wAkelhE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Stable@vger.kernel.org,
	Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>,
	Mark Brown <broonie@kernel.org>
Subject: [PATCH 6.18 188/315] ASoC: qcom: q6asm-dai: fix error handling in prepare and set_params
Date: Sun,  7 Jun 2026 11:59:35 +0200
Message-ID: <20260607095734.484220589@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260607095727.528828913@linuxfoundation.org>
References: <20260607095727.528828913@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-261490-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:Stable@vger.kernel.org,m:srinivas.kandagatla@oss.qualcomm.com,m:broonie@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qualcomm.com:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,linuxfoundation.org:from_mime,linuxfoundation.org:email,msgid.link:url,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E112F64FEC1

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>

commit 4b4db09f283df65d780bc7cee66cb4a7e9bf4770 upstream.

Fix error handling in q6asm_dai_compr_set_params() and q6asm_dai_prepare()
for both CMD_CLOSE and q6asm_unmap_memory_regions().

In both the functions, we are doing q6asm_audio_client_free in failure
cases, which means if prepare or set_params fail, we can never recover.
Now open and close are done in respective dai_open/close functions.

Fixes: 2a9e92d371db ("ASoC: qdsp6: q6asm: Add q6asm dai driver")
Cc: Stable@vger.kernel.org
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
Link: https://patch.msgid.link/20260518092347.3446946-4-srinivas.kandagatla@oss.qualcomm.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/soc/qcom/qdsp6/q6asm-dai.c |   24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

--- a/sound/soc/qcom/qdsp6/q6asm-dai.c
+++ b/sound/soc/qcom/qdsp6/q6asm-dai.c
@@ -235,9 +235,19 @@ static int q6asm_dai_prepare(struct snd_
 	/* rate and channels are sent to audio driver */
 	if (prtd->state == Q6ASM_STREAM_RUNNING) {
 		/* clear the previous setup if any  */
-		q6asm_cmd(prtd->audio_client, prtd->stream_id, CMD_CLOSE);
-		q6asm_unmap_memory_regions(substream->stream,
-					   prtd->audio_client);
+		ret = q6asm_cmd(prtd->audio_client, prtd->stream_id, CMD_CLOSE);
+		if (ret < 0) {
+			dev_err(dev, "Failed to close q6asm stream %d\n", prtd->stream_id);
+			return ret;
+		}
+
+		ret = q6asm_unmap_memory_regions(substream->stream, prtd->audio_client);
+		if (ret < 0) {
+			dev_err(dev, "Failed to unmap memory regions for q6asm stream %d\n",
+				prtd->stream_id);
+			return ret;
+		}
+
 		q6routing_stream_close(soc_prtd->dai_link->id,
 					 substream->stream);
 		prtd->state = Q6ASM_STREAM_STOPPED;
@@ -305,8 +315,6 @@ routing_err:
 	q6asm_cmd(prtd->audio_client, prtd->stream_id,  CMD_CLOSE);
 open_err:
 	q6asm_unmap_memory_regions(substream->stream, prtd->audio_client);
-	q6asm_audio_client_free(prtd->audio_client);
-	prtd->audio_client = NULL;
 
 	return ret;
 }
@@ -903,7 +911,7 @@ static int q6asm_dai_compr_set_params(st
 			      prtd->session_id, dir);
 	if (ret) {
 		dev_err(dev, "Stream reg failed ret:%d\n", ret);
-		goto q6_err;
+		goto routing_err;
 	}
 
 	ret = __q6asm_dai_compr_set_codec_params(component, stream,
@@ -929,11 +937,11 @@ static int q6asm_dai_compr_set_params(st
 	return 0;
 
 q6_err:
+	q6routing_stream_close(rtd->dai_link->id, dir);
+routing_err:
 	q6asm_cmd(prtd->audio_client, prtd->stream_id, CMD_CLOSE);
 
 open_err:
-	q6asm_audio_client_free(prtd->audio_client);
-	prtd->audio_client = NULL;
 	return ret;
 }
 



