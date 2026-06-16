Return-Path: <stable+bounces-264083-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Q2TqFXpuMWqrjAUAu9opvQ
	(envelope-from <stable+bounces-264083-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 17:40:42 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 02EE969145E
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 17:40:42 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=Y5X3+bKK;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-264083-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-264083-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9C08D30508EB
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 15:33:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DD8744BCAF;
	Tue, 16 Jun 2026 15:33:56 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 757A444105C;
	Tue, 16 Jun 2026 15:33:55 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781624036; cv=none; b=oVj33SrV1wRnEnp5dOvijWa8SPfAad0JqLEtD0HDfge+Dmc8G/bln6ktl/BMdZrNkZdrJEhTJuvGqYiuL/+jNrsBKqw1HQlyu908Y8M+MN4/AUQlk8sXisz46a5AdUL18h34fFFQaRNB9U02LbxIJV4B67KWnRxZjy1bQiy4FmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781624036; c=relaxed/simple;
	bh=qVIzYXjrbYyf3cd/Q5bXQ8WbGZZuKDSHJSA9c9ByMEU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X8lMHiASuc8uDcDhTtgKS8vPsAWhcQRahEDwugBgzV/v03Hc34r+6+SAD2tE+EQetjbo8wEuNY8D3DGbZOAwzEbDMIfnvfuf+ErYuQqQp5j/dzF4t+spx6HUOdSlcOXHur8j9TU8QCzd7EhDlqZEogGR10pyf7QwLrDMDU3HKiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Y5X3+bKK; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78D461F000E9;
	Tue, 16 Jun 2026 15:33:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781624035;
	bh=b5NmJ06JaCIEs1QlbBLxrlV20JV1oXoblMXNBOl7bKc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Y5X3+bKKLrDY59dm2TpLR7aj7X+OOd3+jh4/+nHGtegESht4t4vfGpkQYuVWTvDkh
	 L0TAuveaSw5rFjjxlONcsDsLaaq5ST0nU55CQf4uLSLDFFd5Wq6jkb9PcWYwgwPZ5S
	 kvKxiGN/CqcU0U40e1qjwD0rxxtEMwfS0EZzlsLw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Muhammad Bilal <meatuni001@gmail.com>,
	"Rob Herring (Arm)" <robh@kernel.org>
Subject: [PATCH 7.0 260/378] accel/ethosu: fix IFM region index out-of-bounds in command stream parser
Date: Tue, 16 Jun 2026 20:28:11 +0530
Message-ID: <20260616145123.783336484@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616145109.744539446@linuxfoundation.org>
References: <20260616145109.744539446@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-264083-lists,stable=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:meatuni001@gmail.com,m:robh@kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,msgid.link:url,vger.kernel.org:from_smtp,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 02EE969145E

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Muhammad Bilal <meatuni001@gmail.com>

commit 00f547e0dfecf83014fb32bcba587c6b684c1362 upstream.

NPU_SET_IFM_REGION extracts the region index with param & 0x7f, giving
a maximum value of 127. However region_size[] and output_region[] in
struct ethosu_validated_cmdstream_info are both sized to
NPU_BASEP_REGION_MAX (8), giving valid indices [0..7].

Every other region assignment in the same switch uses param & 0x7:
  NPU_SET_OFM_REGION:  st.ofm.region  = param & 0x7;
  NPU_SET_IFM2_REGION: st.ifm2.region = param & 0x7;
  NPU_SET_WEIGHT_REGION: st.weight[0].region = param & 0x7;
  NPU_SET_SCALE_REGION:  st.scale[0].region  = param & 0x7;

The 0x7f mask on IFM is inconsistent and appears to be a typo.

feat_matrix_length() and calc_sizes() use the region index directly
as an array subscript into the kzalloc'd info struct:
  info->region_size[fm->region] = max(...);

A userspace caller supplying NPU_SET_IFM_REGION with param > 7 causes
a write up to 127*8 = 1016 bytes past the start of region_size[],
corrupting adjacent kernel heap data.

Fix by applying the same & 0x7 mask used by all other region
assignments.

Fixes: 5a5e9c0228e6 ("accel: Add Arm Ethos-U NPU driver")
Cc: stable@vger.kernel.org
Signed-off-by: Muhammad Bilal <meatuni001@gmail.com>
Link: https://patch.msgid.link/20260523195159.55801-1-meatuni001@gmail.com
Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/accel/ethosu/ethosu_gem.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/accel/ethosu/ethosu_gem.c
+++ b/drivers/accel/ethosu/ethosu_gem.c
@@ -466,7 +466,7 @@ static int ethosu_gem_cmdstream_copy_and
 			st.ifm.broadcast = param;
 			break;
 		case NPU_SET_IFM_REGION:
-			st.ifm.region = param & 0x7f;
+			st.ifm.region = param & 0x7;
 			break;
 		case NPU_SET_IFM_WIDTH0_M1:
 			st.ifm.width0 = param;



