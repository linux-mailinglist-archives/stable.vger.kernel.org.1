Return-Path: <stable+bounces-233684-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SEe3Nt8v1WmU2AcAu9opvQ
	(envelope-from <stable+bounces-233684-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 18:25:03 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 52CAD3B1CC8
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 18:25:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D3C573060D9A
	for <lists+stable@lfdr.de>; Tue,  7 Apr 2026 16:15:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A92CA396D22;
	Tue,  7 Apr 2026 16:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fEez5voN"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3417839479B
	for <stable@vger.kernel.org>; Tue,  7 Apr 2026 16:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775578525; cv=none; b=ChPQm1AJxAYuihKkaqAitleDed2i2JGU+akLDnbQmoqnJ/k8ly2BWR17rTtbqP8AtdxfUAGdk4hYZFNHZ1qGpVw9C9QfvwBMru6sl66pTB6Z+TLb03+4YisqEpbVUN+MycUwLk/F9Xzp2966DV8Shr0mYE06otxNgvayEjXy1VI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775578525; c=relaxed/simple;
	bh=o+do6eHZ2TlumiKkr5Qf2CmRGDCmiIUGTAMxTniEeyU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kg2dPdamC4zpEmWtmRmBYeINO48B2D54G5Ul84waomeNhSXBJMwE471a8rSk/454c68QLoDI25GmNBkgsFD8vwwhF6nlM7NHjmCSCma+DniYBGt5V9lcHjWEjvnwwYMsncodsEaI/53i1F/SdJAmHTTnyqivTdUnsDrTp9dwoSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fEez5voN; arc=none smtp.client-ip=74.125.82.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-12732165d1eso7248532c88.1
        for <stable@vger.kernel.org>; Tue, 07 Apr 2026 09:15:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775578523; x=1776183323; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=r39jnrPI+M4FZyBd4fpGpsC+wdUlyMZWAwuwD/2KET8=;
        b=fEez5voNpooIOE7EdtN2E6/ywaDafIgjkrNy/VIVqqRfIa55iN9uOKBNpOXgRfef7L
         194NJv27vF4MZHirO9ft5l8A2doXlroxXUKUgGL43rcZN7+9Hfdsnwtu7QkkwLlrofNX
         HIN3jWg2f2EKxKTCnyviVpfnJlerQFeBT++L4U9jUPKsEjCDN1IOqcC0aARZ7s8MadQr
         UD7KbHRY32wYd1cRq494dtf/GvbrwrQculJvGWhzVW3vR1IrVURnE3hNcB2pjj0t0IZb
         +UDTNvv1Za6bSfsLkARI1jV60YaWqpyVNTJ8gPYSVJiNFVUOr7Ha7xJWgVN2SwgIdQab
         UquQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775578523; x=1776183323;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r39jnrPI+M4FZyBd4fpGpsC+wdUlyMZWAwuwD/2KET8=;
        b=OkNmMoasK02oSJqidCv/+pcgi1m+U6O3wIEnM7O3N+iul+fNrexVXjRF/gbas1UmGJ
         EcszOF/COuuz0UDX+8eUlt56z+RtMbhbzH3SfDVfkmRp9VPu/XeH1lEsmL/JRA4Sv8XY
         vo6SfLduq7YXJlfJoh6brB1rZpd6Rnp2X19SELwYyks/LhWGvrtISBxhFjtbF5fzgOSX
         H65D0LZPnn2i6wE+fAR5M6l70d5m30Tm24Llgut9wlLuIwyUyLOypURwbTYgSjIXVMJo
         82nH+WfMsDVBx6TAOk2ojPXHCx7UvvG8boul+YDgyi8xmT5JFivlinJjf6Qtmbnk8cTn
         AIiA==
X-Forwarded-Encrypted: i=1; AJvYcCXjpvwcP4/WlThEjtjZ9998qu9XPGwl/gkq/YXgfKD881cP0lSlUWba1750HFEX+NSZVD9OeBk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGT/3KPR0Sdk9yEe8hjd1HWcwCkAQH1ldbaDaF5AxBpHgwOJ7g
	9zFlxDQHdrPIE6wbjXn/1j+NKJAow5f0UeOvT8X6RFkga+Tu66pQSOy3PnT9PaeeOSs=
X-Gm-Gg: AeBDieut7n+/1UFMfDWMaSXDqtCRD2/uJKaq7Zj+kLEacbziH+4zNKpakThgk7H39V7
	qmsbgY+BepVx7W0d6wF3ok3T771ZYNrpVgY7rhKKQ37gJigs7jrq2qjABtltbIK6xTLsbjiTQR9
	1FP5NcOAH16YT/vooDiUiItkQabUQLQteUFxz5HRmLvep4cuTu6iEA4oD/DiF9+EwNN+5j+3liE
	j5q1+lllkzpwKTz1CU5zgwIqkKQ/9jtA95rjRnGYldondu0GuSnRRt8o8WQ95CUisw6WDQeAcel
	PZZ86wSVoaZfXiWPt5nzR+IfbkJnxmeF+hHNOKafyZDXGzLr93UfAhRnxXLl+iZa3Tm4tDZaY1C
	MkxRYihfZIdePJLaw7A5kHRI5RCse471CmfPBsyT0/EcBEGqsroQ54Uz+ESiK6+tYy0OoOoSe+T
	de2Zw=
X-Received: by 2002:a05:7022:b98:b0:128:df80:1852 with SMTP id a92af1059eb24-12bfb6fe54fmr8400983c88.9.1775578522242;
        Tue, 07 Apr 2026 09:15:22 -0700 (PDT)
Received: from devobuntu.lan ([2600:6c5c:6b00:62b::23])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12bf90973b6sm16870658c88.9.2026.04.07.09.15.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 09:15:21 -0700 (PDT)
From: Matt Vollrath <tactii@gmail.com>
To: intel-wired-lan@osuosl.org
Cc: Matt Vollrath <tactii@gmail.com>,
	Kohei Enju <kohei@enjuk.jp>,
	stable@vger.kernel.org
Subject: [PATCH iwl-net v2] i40e: Cleanup PTP pins on probe failure
Date: Tue,  7 Apr 2026 12:14:47 -0400
Message-ID: <20260407161447.43645-1-tactii@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,enjuk.jp,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-233684-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tactii@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-0.999];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[enjuk.jp:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 52CAD3B1CC8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

PTP pin structs are allocated early in probe, but never cleaned up.

Fix this by calling i40e_ptp_free_pins in the error path.

To support this, i40e_ptp_free_pins is added to the header and
pin_config is correctly nullified after being freed.

This has been an issue since i40e_ptp_alloc_pins was introduced.

Fixes: 1050713026a08 ("i40e: add support for PTP external synchronization clock")
Reported-by: Kohei Enju <kohei@enjuk.jp>
Cc: stable@vger.kernel.org
Signed-off-by: Matt Vollrath <tactii@gmail.com>
---
 drivers/net/ethernet/intel/i40e/i40e.h      | 1 +
 drivers/net/ethernet/intel/i40e/i40e_main.c | 1 +
 drivers/net/ethernet/intel/i40e/i40e_ptp.c  | 3 ++-
 3 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e.h b/drivers/net/ethernet/intel/i40e/i40e.h
index dcb50c2e1aa2..83e780919ac9 100644
--- a/drivers/net/ethernet/intel/i40e/i40e.h
+++ b/drivers/net/ethernet/intel/i40e/i40e.h
@@ -1318,6 +1318,7 @@ void i40e_ptp_restore_hw_time(struct i40e_pf *pf);
 void i40e_ptp_init(struct i40e_pf *pf);
 void i40e_ptp_stop(struct i40e_pf *pf);
 int i40e_ptp_alloc_pins(struct i40e_pf *pf);
+void i40e_ptp_free_pins(struct i40e_pf *pf);
 int i40e_update_adq_vsi_queues(struct i40e_vsi *vsi, int vsi_offset);
 int i40e_is_vsi_uplink_mode_veb(struct i40e_vsi *vsi);
 int i40e_get_partition_bw_setting(struct i40e_pf *pf);
diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 926d001b2150..c7062aa476dd 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -16112,6 +16112,7 @@ static int i40e_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	i40e_clear_interrupt_scheme(pf);
 	kfree(pf->vsi);
 err_switch_setup:
+	i40e_ptp_free_pins(pf);
 	i40e_reset_interrupt_capability(pf);
 	timer_shutdown_sync(&pf->service_timer);
 err_mac_addr:
diff --git a/drivers/net/ethernet/intel/i40e/i40e_ptp.c b/drivers/net/ethernet/intel/i40e/i40e_ptp.c
index 404a716db8da..7d07c389bb23 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ptp.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ptp.c
@@ -940,12 +940,13 @@ int i40e_ptp_hwtstamp_get(struct net_device *netdev,
  *
  * Release memory allocated for PTP pins.
  **/
-static void i40e_ptp_free_pins(struct i40e_pf *pf)
+void i40e_ptp_free_pins(struct i40e_pf *pf)
 {
 	if (i40e_is_ptp_pin_dev(&pf->hw)) {
 		kfree(pf->ptp_pins);
 		kfree(pf->ptp_caps.pin_config);
 		pf->ptp_pins = NULL;
+		pf->ptp_caps.pin_config = NULL;
 	}
 }
 
-- 
2.43.0

v2:
* No need to guard kfree of NULL
* Followed Dawid's instructions re: target tree, Cc, changelog


