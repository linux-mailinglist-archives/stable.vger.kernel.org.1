Return-Path: <stable+bounces-225781-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IH0RKackuWm1sQEAu9opvQ
	(envelope-from <stable+bounces-225781-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 10:53:43 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 909772A74EC
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 10:53:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C030F30229B2
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 09:15:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C5B434FF48;
	Tue, 17 Mar 2026 09:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="m3c5p06h"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76046356A12
	for <stable@vger.kernel.org>; Tue, 17 Mar 2026 09:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773738946; cv=none; b=IzbYUr0LM9amMM4mNfXBsoqXnmeHgVXUYEPPLZ4Soh/VrKcU55WFk8wgWT6Gbe9iacLGBOIMv0s+07y7Ih3QRU2v4adT0dAvWr85V2X38Iz++UGkSiQgTRMS/FK7JboWLBpG7CicpnNNLkVqLzlA56AupVwuI1t4/mjUvRRI2H8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773738946; c=relaxed/simple;
	bh=krrHZJm9Gj4wVWrUi4Qv6sVGpRSFX2PgIA1+E2ywKP4=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Abgt6VKWx2Lj7Dtk98BCvikchZCgaFfKhHsEILaVrBT44g1j4MLG28DTztfnpJKPe5jwXBsCpX0e9BdbXRhLoNEJyvMmgUDFN4lhN66mlelcAuop3DJXerKgYxJF0YJ/RAIJ7b7OOYIvSJUm7VgKJEBfcBjyKPQvVTHTDUQ/G7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=m3c5p06h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1E46C19425;
	Tue, 17 Mar 2026 09:15:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773738945;
	bh=krrHZJm9Gj4wVWrUi4Qv6sVGpRSFX2PgIA1+E2ywKP4=;
	h=Subject:To:Cc:From:Date:From;
	b=m3c5p06hRSfcSRZvuVhPFzBf5UJhmUYwbSCUM8YCUCO44tZNa5e+i1Jn/Z5N4Adhv
	 wNo0nUXZ6kJNJ4L51TU6pDP9EVTJPLcBitwI1e1NF/Ps0WvGu+GWwNlKHHg4ggx+s5
	 tC42JNKwidHKUGYuvkB+DegLilCoNJYEiPbzDDmk=
Subject: FAILED: patch "[PATCH] ASoC: qcom: qdsp6: Fix q6apm remove ordering during ADSP stop" failed to apply to 6.1-stable tree
To: ravi.hothi@oss.qualcomm.com,broonie@kernel.org,srinivas.kandagatla@oss.qualcomm.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 17 Mar 2026 10:15:41 +0100
Message-ID: <2026031741-sleep-elderly-6a8f@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [6.14 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_REJECT(1.00)[signature check failed: fail, {[1] = sig:subspace.kernel.org:reject}];
	R_DKIM_REJECT(1.00)[linuxfoundation.org:s=korg];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[linuxfoundation.org : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-225781-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	GREYLIST(0.00)[pass,body];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-0.159];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:-];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NO_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,msgid.link:url,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 909772A74EC
X-Rspamd-Action: add header
X-Rspamd-Server: lfdr
X-Spam: Yes


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x d6db827b430bdcca3976cebca7bd69cca03cde2c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026031741-sleep-elderly-6a8f@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From d6db827b430bdcca3976cebca7bd69cca03cde2c Mon Sep 17 00:00:00 2001
From: Ravi Hothi <ravi.hothi@oss.qualcomm.com>
Date: Fri, 27 Feb 2026 20:15:34 +0530
Subject: [PATCH] ASoC: qcom: qdsp6: Fix q6apm remove ordering during ADSP stop
 and start

During ADSP stop and start, the kernel crashes due to the order in which
ASoC components are removed.

On ADSP stop, the q6apm-audio .remove callback unloads topology and removes
PCM runtimes during ASoC teardown. This deletes the RTDs that contain the
q6apm DAI components before their removal pass runs, leaving those
components still linked to the card and causing crashes on the next rebind.

Fix this by ensuring that all dependent (child) components are removed
first, and the q6apm component is removed last.

[   48.105720] Unable to handle kernel NULL pointer dereference at virtual address 00000000000000d0
[   48.114763] Mem abort info:
[   48.117650]   ESR = 0x0000000096000004
[   48.121526]   EC = 0x25: DABT (current EL), IL = 32 bits
[   48.127010]   SET = 0, FnV = 0
[   48.130172]   EA = 0, S1PTW = 0
[   48.133415]   FSC = 0x04: level 0 translation fault
[   48.138446] Data abort info:
[   48.141422]   ISV = 0, ISS = 0x00000004, ISS2 = 0x00000000
[   48.147079]   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
[   48.152354]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
[   48.157859] user pgtable: 4k pages, 48-bit VAs, pgdp=00000001173cf000
[   48.164517] [00000000000000d0] pgd=0000000000000000, p4d=0000000000000000
[   48.171530] Internal error: Oops: 0000000096000004 [#1]  SMP
[   48.177348] Modules linked in: q6prm_clocks q6apm_lpass_dais q6apm_dai snd_q6dsp_common q6prm snd_q6apm 8021q garp mrp stp llc snd_soc_hdmi_codec apr pdr_interface phy_qcom_edp fastrpc qcom_pd_mapper rpmsg_ctrl qrtr_smd rpmsg_char qcom_pdr_msg qcom_iris v4l2_mem2mem videobuf2_dma_contig ath11k_pci msm ubwc_config at24 ath11k videobuf2_memops mac80211 ocmem videobuf2_v4l2 libarc4 drm_gpuvm mhi qrtr videodev drm_exec snd_soc_sc8280xp gpu_sched videobuf2_common nvmem_qcom_spmi_sdam snd_soc_qcom_sdw drm_dp_aux_bus qcom_q6v5_pas qcom_spmi_temp_alarm snd_soc_qcom_common rtc_pm8xxx qcom_pon drm_display_helper cec qcom_pil_info qcom_stats soundwire_bus drm_client_lib mc dispcc0_sa8775p videocc_sa8775p qcom_q6v5 camcc_sa8775p snd_soc_dmic phy_qcom_sgmii_eth snd_soc_max98357a i2c_qcom_geni snd_soc_core dwmac_qcom_ethqos llcc_qcom icc_bwmon qcom_sysmon snd_compress qcom_refgen_regulator coresight_stm stmmac_platform snd_pcm_dmaengine qcom_common coresight_tmc stmmac coresight_replicator qcom
 _glink_smem coresight_cti stm_core
[   48.177444]  coresight_funnel snd_pcm ufs_qcom phy_qcom_qmp_usb gpi phy_qcom_snps_femto_v2 coresight phy_qcom_qmp_ufs qcom_wdt gpucc_sa8775p pcs_xpcs mdt_loader qcom_ice icc_osm_l3 qmi_helpers snd_timer snd soundcore display_connector qcom_rng nvmem_reboot_mode drm_kms_helper phy_qcom_qmp_pcie sha256 cfg80211 rfkill socinfo fuse drm backlight ipv6
[   48.301059] CPU: 2 UID: 0 PID: 293 Comm: kworker/u32:2 Not tainted 6.19.0-rc6-dirty #10 PREEMPT
[   48.310081] Hardware name: Qualcomm Technologies, Inc. Lemans EVK (DT)
[   48.316782] Workqueue: pdr_notifier_wq pdr_notifier_work [pdr_interface]
[   48.323672] pstate: 20400005 (nzCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[   48.330825] pc : mutex_lock+0xc/0x54
[   48.334514] lr : soc_dapm_shutdown_dapm+0x44/0x174 [snd_soc_core]
[   48.340794] sp : ffff800084ddb7b0
[   48.344207] x29: ffff800084ddb7b0 x28: ffff00009cd9cf30 x27: ffff00009cd9cc00
[   48.351544] x26: ffff000099610190 x25: ffffa31d2f19c810 x24: ffffa31d2f185098
[   48.358869] x23: ffff800084ddb7f8 x22: 0000000000000000 x21: 00000000000000d0
[   48.366198] x20: ffff00009ba6c338 x19: ffff00009ba6c338 x18: 00000000ffffffff
[   48.373528] x17: 000000040044ffff x16: ffffa31d4ae6dca8 x15: 072007740775076f
[   48.380853] x14: 0765076d07690774 x13: 00313a323a656369 x12: 767265733a637673
[   48.388182] x11: 00000000000003f9 x10: ffffa31d4c7dea98 x9 : 0000000000000001
[   48.395519] x8 : ffff00009a2aadc0 x7 : 0000000000000003 x6 : 0000000000000000
[   48.402854] x5 : 0000000000000000 x4 : 0000000000000028 x3 : ffff000ef397a698
[   48.410180] x2 : ffff00009a2aadc0 x1 : 0000000000000000 x0 : 00000000000000d0
[   48.417506] Call trace:
[   48.420025]  mutex_lock+0xc/0x54 (P)
[   48.423712]  snd_soc_dapm_shutdown+0x44/0xbc [snd_soc_core]
[   48.429447]  soc_cleanup_card_resources+0x30/0x2c0 [snd_soc_core]
[   48.435719]  snd_soc_bind_card+0x4dc/0xcc0 [snd_soc_core]
[   48.441278]  snd_soc_add_component+0x27c/0x2c8 [snd_soc_core]
[   48.447192]  snd_soc_register_component+0x9c/0xf4 [snd_soc_core]
[   48.453371]  devm_snd_soc_register_component+0x64/0xc4 [snd_soc_core]
[   48.459994]  apm_probe+0xb4/0x110 [snd_q6apm]
[   48.464479]  apr_device_probe+0x24/0x40 [apr]
[   48.468964]  really_probe+0xbc/0x298
[   48.472651]  __driver_probe_device+0x78/0x12c
[   48.477132]  driver_probe_device+0x40/0x160
[   48.481435]  __device_attach_driver+0xb8/0x134
[   48.486011]  bus_for_each_drv+0x80/0xdc
[   48.489964]  __device_attach+0xa8/0x1b0
[   48.493916]  device_initial_probe+0x50/0x54
[   48.498219]  bus_probe_device+0x38/0xa0
[   48.502170]  device_add+0x590/0x760
[   48.505761]  device_register+0x20/0x30
[   48.509623]  of_register_apr_devices+0x1d8/0x318 [apr]
[   48.514905]  apr_pd_status+0x2c/0x54 [apr]
[   48.519114]  pdr_notifier_work+0x8c/0xe0 [pdr_interface]
[   48.524570]  process_one_work+0x150/0x294
[   48.528692]  worker_thread+0x2d8/0x3d8
[   48.532551]  kthread+0x130/0x204
[   48.535874]  ret_from_fork+0x10/0x20
[   48.539559] Code: d65f03c0 d5384102 d503201f d2800001 (c8e17c02)
[   48.545823] ---[ end trace 0000000000000000 ]---

Fixes: 5477518b8a0e ("ASoC: qdsp6: audioreach: add q6apm support")
Cc: stable@vger.kernel.org
Signed-off-by: Ravi Hothi <ravi.hothi@oss.qualcomm.com>
Reviewed-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
Link: https://patch.msgid.link/20260227144534.278568-1-ravi.hothi@oss.qualcomm.com
Signed-off-by: Mark Brown <broonie@kernel.org>

diff --git a/sound/soc/qcom/qdsp6/q6apm-dai.c b/sound/soc/qcom/qdsp6/q6apm-dai.c
index de3bdac3e791..168c166c960d 100644
--- a/sound/soc/qcom/qdsp6/q6apm-dai.c
+++ b/sound/soc/qcom/qdsp6/q6apm-dai.c
@@ -838,6 +838,7 @@ static const struct snd_soc_component_driver q6apm_fe_dai_component = {
 	.ack		= q6apm_dai_ack,
 	.compress_ops	= &q6apm_dai_compress_ops,
 	.use_dai_pcm_id = true,
+	.remove_order   = SND_SOC_COMP_ORDER_EARLY,
 };
 
 static int q6apm_dai_probe(struct platform_device *pdev)
diff --git a/sound/soc/qcom/qdsp6/q6apm-lpass-dais.c b/sound/soc/qcom/qdsp6/q6apm-lpass-dais.c
index 528756f1332b..5be37eeea329 100644
--- a/sound/soc/qcom/qdsp6/q6apm-lpass-dais.c
+++ b/sound/soc/qcom/qdsp6/q6apm-lpass-dais.c
@@ -278,6 +278,7 @@ static const struct snd_soc_component_driver q6apm_lpass_dai_component = {
 	.of_xlate_dai_name = q6dsp_audio_ports_of_xlate_dai_name,
 	.be_pcm_base = AUDIOREACH_BE_PCM_BASE,
 	.use_dai_pcm_id = true,
+	.remove_order   = SND_SOC_COMP_ORDER_FIRST,
 };
 
 static int q6apm_lpass_dai_dev_probe(struct platform_device *pdev)
diff --git a/sound/soc/qcom/qdsp6/q6apm.c b/sound/soc/qcom/qdsp6/q6apm.c
index 44841fde3856..970b08c89bb3 100644
--- a/sound/soc/qcom/qdsp6/q6apm.c
+++ b/sound/soc/qcom/qdsp6/q6apm.c
@@ -715,6 +715,7 @@ static const struct snd_soc_component_driver q6apm_audio_component = {
 	.name		= APM_AUDIO_DRV_NAME,
 	.probe		= q6apm_audio_probe,
 	.remove		= q6apm_audio_remove,
+	.remove_order   = SND_SOC_COMP_ORDER_LAST,
 };
 
 static int apm_probe(gpr_device_t *gdev)


