Return-Path: <stable+bounces-210665-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SCeyFcBAcGnXXAAAu9opvQ
	(envelope-from <stable+bounces-210665-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 03:58:08 +0100
X-Original-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B788F501F3
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 03:58:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C01E4BC87B2
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 02:57:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F37A22989A2;
	Wed, 21 Jan 2026 02:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Aqucc9h8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0335A2BEC43
	for <stable@vger.kernel.org>; Wed, 21 Jan 2026 02:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768964262; cv=none; b=m5HVCQ3vwckNbQclwyHoupPj46W1TaY9MYk2RrErL+JxjGqe9q1d6nCtwiAOETgmXuBwm70Jp/k996RspMHfGwpIQn7Vl32knGytQgNaarIDZw8lZyfAwsEP73EFSyCfcTErcTc9V+4gZvn/ygYnkcr/xr2T3OE2y+GarPrI1m0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768964262; c=relaxed/simple;
	bh=Re5V8BlTedrsxT52UlriaGIaFT9eAG3mA+0weg6oGIE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aPK4qZodjkjgwK5vSalpVmlMcxC943LwzcNoglbBw+oHnFNFPoqb3o/xldoaulWb9ILTe2/L4ZeiD9v/ysA0ULzcGjl0KbZ01N1miMqOgRRNNJZ2/q3U9kmJSC+RPwq8G6+aNdcrwEP1d3B4hu0Sgw19tsCxiCUxyM/tv21UhQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Aqucc9h8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3ACCDC16AAE;
	Wed, 21 Jan 2026 02:57:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768964260;
	bh=Re5V8BlTedrsxT52UlriaGIaFT9eAG3mA+0weg6oGIE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Aqucc9h8rU4AQSDNUJ0cXbdASkKxLp2GdLe/BPjh3ZMmHxL86h1oVIZlmmbDH7p8J
	 JhHdSqJ0LtlFpywQn/I09Nb6dT6Ym7dx4AoNv3vGerPV0+9JYH7OONaAftk+1CSHcm
	 +ashwTWUWe29+OUAgh90RT73HILalUuCXMgvf1ozOib3IFMTj5qlU7eIhpqGPnife/
	 owgdc3khhk+ZtR9jfmgdfXdcG/85qckcqwfwOav5C5e9Rsux06Sid7u3OPQ6XEPei/
	 dXyuXRZ0JPsY1oFMN/zo6SOXX6PgPS+nLWBubSTbND8PA6dUV86Iw6IFwo0H2POAP6
	 aBVKVMqMCbRBg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
	Borislav Petkov <bp@suse.de>,
	Reinette Chatre <reinette.chatre@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 1/2] x86/resctrl: Fix kernel-doc in internal.h
Date: Tue, 20 Jan 2026 21:57:37 -0500
Message-ID: <20260121025738.1158111-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2026012056-existing-collide-49ad@gregkh>
References: <2026012056-existing-collide-49ad@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.46 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-210665-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,suse.de,intel.com,kernel.org];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,suse.de:email,dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: B788F501F3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: "Fabio M. De Francesco" <fmdefrancesco@gmail.com>

[ Upstream commit fd2afa70eff057fab57c9e06708b68677b261a0c ]

Add description of undocumented parameters. Issues detected by
scripts/kernel-doc.

Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Link: https://lkml.kernel.org/r/20210618223206.29539-1-fmdefrancesco@gmail.com
Stable-dep-of: 6ee98aabdc70 ("x86/resctrl: Add missing resctrl initialization for Hygon")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kernel/cpu/resctrl/internal.h | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index f65d3c0dbc417..ec35fcad29356 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -70,6 +70,7 @@ DECLARE_STATIC_KEY_FALSE(rdt_mon_enable_key);
  * struct mon_evt - Entry in the event list of a resource
  * @evtid:		event id
  * @name:		name of the event
+ * @list:		entry in &rdt_resource->evt_list
  */
 struct mon_evt {
 	u32			evtid;
@@ -78,10 +79,13 @@ struct mon_evt {
 };
 
 /**
- * struct mon_data_bits - Monitoring details for each event file
- * @rid:               Resource id associated with the event file.
+ * union mon_data_bits - Monitoring details for each event file
+ * @priv:              Used to store monitoring event data in @u
+ *                     as kernfs private data
+ * @rid:               Resource id associated with the event file
  * @evtid:             Event id associated with the event file
  * @domid:             The domain to which the event file belongs
+ * @u:                 Name of the bit fields struct
  */
 union mon_data_bits {
 	void *priv;
@@ -119,6 +123,7 @@ enum rdt_group_type {
  * @RDT_MODE_PSEUDO_LOCKSETUP: Resource group will be used for Pseudo-Locking
  * @RDT_MODE_PSEUDO_LOCKED: No sharing of this resource group's allocations
  *                          allowed AND the allocations are Cache Pseudo-Locked
+ * @RDT_NUM_MODES: Total number of modes
  *
  * The mode of a resource group enables control over the allowed overlap
  * between allocations associated with different resource groups (classes
@@ -142,7 +147,7 @@ enum rdtgrp_mode {
 
 /**
  * struct mongroup - store mon group's data in resctrl fs.
- * @mon_data_kn		kernlfs node for the mon_data directory
+ * @mon_data_kn:		kernfs node for the mon_data directory
  * @parent:			parent rdtgrp
  * @crdtgrp_list:		child rdtgroup node list
  * @rmid:			rmid for this rdtgroup
@@ -282,11 +287,11 @@ struct rftype {
 /**
  * struct mbm_state - status for each MBM counter in each domain
  * @chunks:	Total data moved (multiply by rdt_group.mon_scale to get bytes)
- * @prev_msr	Value of IA32_QM_CTR for this RMID last time we read it
+ * @prev_msr:	Value of IA32_QM_CTR for this RMID last time we read it
  * @prev_bw_msr:Value of previous IA32_QM_CTR for bandwidth counting
- * @prev_bw	The most recent bandwidth in MBps
- * @delta_bw	Difference between the current and previous bandwidth
- * @delta_comp	Indicates whether to compute the delta_bw
+ * @prev_bw:	The most recent bandwidth in MBps
+ * @delta_bw:	Difference between the current and previous bandwidth
+ * @delta_comp:	Indicates whether to compute the delta_bw
  */
 struct mbm_state {
 	u64	chunks;
@@ -456,11 +461,13 @@ struct rdt_parse_data {
  * @data_width:		Character width of data when displaying
  * @domains:		All domains for this resource
  * @cache:		Cache allocation related data
+ * @membw:		If the component has bandwidth controls, their properties.
  * @format_str:		Per resource format string to show domain value
  * @parse_ctrlval:	Per resource function pointer to parse control values
  * @evt_list:		List of monitoring events
  * @num_rmid:		Number of RMIDs available
  * @mon_scale:		cqm counter * mon_scale = occupancy in bytes
+ * @mbm_width:		Monitor width, to detect and correct for overflow.
  * @fflags:		flags to choose base and info files
  */
 struct rdt_resource {
-- 
2.51.0


