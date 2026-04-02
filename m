Return-Path: <stable+bounces-232931-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MBvRM9kkzmnElAYAu9opvQ
	(envelope-from <stable+bounces-232931-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 02 Apr 2026 10:12:09 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C6044385AAE
	for <lists+stable@lfdr.de>; Thu, 02 Apr 2026 10:12:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 03501303D642
	for <lists+stable@lfdr.de>; Thu,  2 Apr 2026 08:11:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 840D53A16AC;
	Thu,  2 Apr 2026 08:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PbSkNWHg";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZdqPHOoO"
X-Original-To: Stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73DC03A382E
	for <Stable@vger.kernel.org>; Thu,  2 Apr 2026 08:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775117503; cv=none; b=C1dg0JdqN+dPIQqtH/6LOIadTdlbxhIFhV2xcxQNrAra/JdJ8SpmONLjGFxeLW4cOv7nK7SMd2uW0oKuUEoTRllctMdv5M70Xq017Krmg+s9H/jipcGZ3lH7FDER3KyDmncKLXhK/rzcTu+cr1wxaE+ySaKDwpJlnEZoGhdq3ME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775117503; c=relaxed/simple;
	bh=V5T/qd3TANJw1qd6u6VahJ4dPBNJ8hf0QkxJzpbMCss=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=buIeHOd0VuzjkFSEuH6svPqFtuYYSOeyUBdShL7LsXPlEyNOhdu2UCDA+9A0TjKs5AjNg5iRf39TKv5okFAFLnkx2uTk6McFpw3wRAKtCR8r5aUh7nPscgrN4b7xCdybRmibo3QrcxsK4GavNrFtahm1MIyG4NDnKXucW3aPGg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PbSkNWHg; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ZdqPHOoO; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6326lxn52903279
	for <Stable@vger.kernel.org>; Thu, 2 Apr 2026 08:11:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=8DfOih8+t/M
	QOB/k+M2wMzlDBSpU8tbUdV4SGt46IdA=; b=PbSkNWHgCqkcFCppadxGwJj/V0M
	4tIf033fSqeY2BntTkz0Xul6lzR8GgjgYMrbqsCySi3J+SwVkGUkbrfOFdz6tnwL
	3pef/4LWObTd0t0vvKZTctrrunk67r5TO+ZIR7FKTSKIZqatnqhUC4yVn/XfOjXo
	o2+2D7d1p+uvfiSTNf+pwIhfrUjeenGpNnRBmDCnEgJ1X3GKafiEIMBJquHEwJCG
	5ZoDJUZovVJ01QB3egM+7sEmbx01PCG7zgrq7W2EokjbVD7M3wPUV0YG1nufkRYX
	shVzGYlA87tcxANyGr6uCQH6rfEuP0BgLkJUuZi0nHIcZrn9qSHQ94eHHHw==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d954cbnyh-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <Stable@vger.kernel.org>; Thu, 02 Apr 2026 08:11:30 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-5090cc6a7d2so17778951cf.2
        for <Stable@vger.kernel.org>; Thu, 02 Apr 2026 01:11:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1775117490; x=1775722290; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8DfOih8+t/MQOB/k+M2wMzlDBSpU8tbUdV4SGt46IdA=;
        b=ZdqPHOoOA4JUWVttAZKSA/bvTx6Qkm7wLn/1iyvpf59Ssns7x7Zidrc4lhqRMI3ZXt
         Uy6i/ud6m1lorYuNr3zZOyStRpXto4yMCVwZ+n6yUQ72MmI24TGTDiZPi0b7f4+IJmzc
         YVVeyxLG7Avz677hPIz6b2Xb3LV6HDW+UojoYp5wgnh5XetFrpYFsJWPWQaHPe1ekCex
         QWWssq9Wq0IAvJ8vGCm6HoIUb5e5a8ugQh/Sro8jwONGGYzznN0WrIeXkAH5NjGm23A9
         ABmLfFSrk2UsCNR0VJBADKQnGo41a2C++3sqoSzAO5Xo9onTYLW7CV7QXpzrkLqBcLbr
         CH9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775117490; x=1775722290;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8DfOih8+t/MQOB/k+M2wMzlDBSpU8tbUdV4SGt46IdA=;
        b=Qn0Wct2pVGYZZ/HLgYqLr7yVzI55ss19brDt2d1iijHpIc411aJD9tpYFhb+RD4UkM
         WeVv7wwa1U0tINJJOSbVHdZqQafwfxdBDSeWIEowTZJmmg09dZRCVXq6v1ULUEx/SL9D
         ZvAsX/5ijK0PMhEhrNxq9icgTWbbHpU2Vg8gjfS3Q0meV35adusFHS0mxPpz4zZ8+VY/
         k3t1AfmcVkyk7HK4nhlGPiK91Ek4mu/kPULJ/E27pNMOGWCiHyOZ84ELzQh2XBsWZzkv
         gsHlmpFPby0UfFxQHfdmxm+3qXMsxQU9Mvc0MeAgLZEI9VFqHOvR+flZwrxtFAX+ro0E
         WKJg==
X-Forwarded-Encrypted: i=1; AJvYcCXYvOr3WjYzHI8/F5Hbly7NTxdzCMs78DLXGmZ/eT69hr6G/H1JKqyq8QODco7LKuDpe00TaMg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdJgYz7Iz8av213Bqik3MfwczkzMOazXBRRXGpzCbQeYwenkDS
	HL6qF+7go5Zn24VIHKhiE8nJhRjWCoBNDQ+lNPlOGJYGWx/dbh/UgBOhD/nl+qY2fxWGT+GCYF2
	E+72a/54k7YnryIDrRnjeEa1xZJh5Yh3DlnTNYbtzZk5RqNCdkaV0UoY2ZSs=
X-Gm-Gg: ATEYQzyvKCceoUFEc/AI2eRILlcqZO5/Vn1v9mxcu03ZWqNWlhWTyAZ81QpeWTvl+RQ
	+AVGDRHOpeLIAIfR5VcyI8eBQIbM+NOfxQ960HnQUI9fGXUmNCzvqTMLbObhlVxFxDm7r7J7wWa
	hFwaBzaqcvZn2m5n8IUrz3S65zopTlFkqG2bk+lBDP2CAHDy+8x4HY91JfTpGTwZPL3QsWSoJH8
	WqHPpNx7r58SIYNPZoIuw81Ag3hIBU2DxY/FMl74/UTgfxkP5eGTHZRser56nKdOem8hwJiKeQH
	IWraw1hSjOkddLdJgzEj1SPUNjk3P0tuVnh02c0fdRqL+ZGI5xTbk0VPMg5OmKNImpFxrwJlUyu
	H4vgX3ljUy9PbuWVbKmxq3aySQQB2PTFcSl1JSprlKTBbKUYTy4oT3Kk=
X-Received: by 2002:a05:622a:5a1a:b0:509:e68:22de with SMTP id d75a77b69052e-50d3bcad22fmr89985551cf.32.1775117489666;
        Thu, 02 Apr 2026 01:11:29 -0700 (PDT)
X-Received: by 2002:a05:622a:5a1a:b0:509:e68:22de with SMTP id d75a77b69052e-50d3bcad22fmr89985181cf.32.1775117489213;
        Thu, 02 Apr 2026 01:11:29 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d1e2c3a01sm5712604f8f.12.2026.04.02.01.11.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 01:11:28 -0700 (PDT)
From: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
To: broonie@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org
Cc: mohammad.rafi.shaik@oss.qualcomm.com, linux-sound@vger.kernel.org,
        lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com, johan@kernel.org,
        dmitry.baryshkov@oss.qualcomm.com, konrad.dybcio@oss.qualcomm.com,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, srini@kernel.org, val@packett.cool,
        mailingradian@gmail.com,
        Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>,
        Stable@vger.kernel.org
Subject: [PATCH v9 01/13] ASoC: qcom: q6apm: move component registration to unmanaged version
Date: Thu,  2 Apr 2026 08:11:06 +0000
Message-ID: <20260402081118.348071-2-srinivas.kandagatla@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260402081118.348071-1-srinivas.kandagatla@oss.qualcomm.com>
References: <20260402081118.348071-1-srinivas.kandagatla@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=WMlyn3sR c=1 sm=1 tr=0 ts=69ce24b2 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=ZsC4DHZuhs/kKio7QBcDoQ==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=ZjLH_7kMUelE1Q3ziugA:9 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-GUID: PMqC0FeRPKjxkQlWsTmtTkUrdj3NBoN5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAyMDA3MiBTYWx0ZWRfX+G+eT1aFjrU0
 +uH88IO8nIkr+zJp5OxHtqbL5taGPbyPXM0HiIcFHMNbDsCl4zznyk6RVMHRTPfqIwZdbwfASY4
 O8D6Sxm/966L+p89O32we1FSy8gWnOCx+lc4yFJahNwyMfDvJ02VBtw8qpJ1tDKt02ijsF30M/2
 48SF/ovG2Op/sAxHYtaZWRxD/3b83+rKqrrrcv/NMIt5jN7b8VdU/vdPlOTqO5j0uBZVta6hjq5
 /91lmv+ynHzA5mEHdyv8nrYUnIZW5FS0glwKxe+iRtgIhnyssv9hh6DesS9sSPFLepOVwchc4Ja
 jWzJLdApHDabRBsvFvBmCuyvxRymOB/fh0FtxjGaqGkvKCgFNYElL5nGwf47R8CChBKrr+OKe4O
 NN+yxnvmxNgCzDzWG40BTAtve/v7vp/bLwc4wFs4T/mK6byty61fxRfQRXJtTNeK4EcgI2W0k9P
 v8oZgYNv1KPH+80B9bg==
X-Proofpoint-ORIG-GUID: PMqC0FeRPKjxkQlWsTmtTkUrdj3NBoN5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-02_01,2026-04-02_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 priorityscore=1501 phishscore=0 suspectscore=0
 clxscore=1015 malwarescore=0 lowpriorityscore=0 spamscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604020072
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[oss.qualcomm.com,vger.kernel.org,gmail.com,perex.cz,suse.com,kernel.org,packett.cool];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-232931-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[srinivas.kandagatla@oss.qualcomm.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,qualcomm.com:dkim,qualcomm.com:email];
	TAGGED_RCPT(0.00)[stable,dt];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: C6044385AAE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

q6apm component registers dais dynamically from ASoC toplology, which
are allocated using device managed version apis. Allocating both
component and dynamic dais using managed version could lead to incorrect
free ordering, dai will be freed while component still holding references
to it.

Fix this issue by moving component to unmanged version so
that the dai pointers are only freeded after the component is removed.

==================================================================
BUG: KASAN: slab-use-after-free in snd_soc_del_component_unlocked+0x3d4/0x400 [snd_soc_core]
Read of size 8 at addr ffff00084493a6e8 by task kworker/u48:0/3426
Tainted: [W]=WARN
Hardware name: LENOVO 21N2ZC5PUS/21N2ZC5PUS, BIOS N42ET57W (1.31 ) 08/08/2024
Workqueue: pdr_notifier_wq pdr_notifier_work [pdr_interface]
Call trace:
 show_stack+0x28/0x7c (C)
 dump_stack_lvl+0x60/0x80
 print_report+0x160/0x4b4
 kasan_report+0xac/0xfc
 __asan_report_load8_noabort+0x20/0x34
 snd_soc_del_component_unlocked+0x3d4/0x400 [snd_soc_core]
 snd_soc_unregister_component_by_driver+0x50/0x88 [snd_soc_core]
 devm_component_release+0x30/0x5c [snd_soc_core]
 devres_release_all+0x13c/0x210
 device_unbind_cleanup+0x20/0x190
 device_release_driver_internal+0x350/0x468
 device_release_driver+0x18/0x30
 bus_remove_device+0x1a0/0x35c
 device_del+0x314/0x7f0
 device_unregister+0x20/0xbc
 apr_remove_device+0x5c/0x7c [apr]
 device_for_each_child+0xd8/0x160
 apr_pd_status+0x7c/0xa8 [apr]
 pdr_notifier_work+0x114/0x240 [pdr_interface]
 process_one_work+0x500/0xb70
 worker_thread+0x630/0xfb0
 kthread+0x370/0x6c0
 ret_from_fork+0x10/0x20

Allocated by task 77:
 kasan_save_stack+0x40/0x68
 kasan_save_track+0x20/0x40
 kasan_save_alloc_info+0x44/0x58
 __kasan_kmalloc+0xbc/0xdc
 __kmalloc_node_track_caller_noprof+0x1f4/0x620
 devm_kmalloc+0x7c/0x1c8
 snd_soc_register_dai+0x50/0x4f0 [snd_soc_core]
 soc_tplg_pcm_elems_load+0x55c/0x1eb8 [snd_soc_core]
 snd_soc_tplg_component_load+0x4f8/0xb60 [snd_soc_core]
 audioreach_tplg_init+0x124/0x1fc [snd_q6apm]
 q6apm_audio_probe+0x10/0x1c [snd_q6apm]
 snd_soc_component_probe+0x5c/0x118 [snd_soc_core]
 soc_probe_component+0x44c/0xaf0 [snd_soc_core]
 snd_soc_bind_card+0xad0/0x2370 [snd_soc_core]
 snd_soc_register_card+0x3b0/0x4c0 [snd_soc_core]
 devm_snd_soc_register_card+0x50/0xc8 [snd_soc_core]
 x1e80100_platform_probe+0x208/0x368 [snd_soc_x1e80100]
 platform_probe+0xc0/0x188
 really_probe+0x188/0x804
 __driver_probe_device+0x158/0x358
 driver_probe_device+0x60/0x190
 __device_attach_driver+0x16c/0x2a8
 bus_for_each_drv+0x100/0x194
 __device_attach+0x174/0x380
 device_initial_probe+0x14/0x20
 bus_probe_device+0x124/0x154
 deferred_probe_work_func+0x140/0x220
 process_one_work+0x500/0xb70
 worker_thread+0x630/0xfb0
 kthread+0x370/0x6c0
 ret_from_fork+0x10/0x20

Freed by task 3426:
 kasan_save_stack+0x40/0x68
 kasan_save_track+0x20/0x40
 __kasan_save_free_info+0x4c/0x80
 __kasan_slab_free+0x78/0xa0
 kfree+0x100/0x4a4
 devres_release_all+0x144/0x210
 device_unbind_cleanup+0x20/0x190
 device_release_driver_internal+0x350/0x468
 device_release_driver+0x18/0x30
 bus_remove_device+0x1a0/0x35c
 device_del+0x314/0x7f0
 device_unregister+0x20/0xbc
 apr_remove_device+0x5c/0x7c [apr]
 device_for_each_child+0xd8/0x160
 apr_pd_status+0x7c/0xa8 [apr]
 pdr_notifier_work+0x114/0x240 [pdr_interface]
 process_one_work+0x500/0xb70
 worker_thread+0x630/0xfb0
 kthread+0x370/0x6c0
 ret_from_fork+0x10/0x20

Fixes: 5477518b8a0e ("ASoC: qdsp6: audioreach: add q6apm support")
Cc: <Stable@vger.kernel.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
---
 sound/soc/qcom/qdsp6/q6apm.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/sound/soc/qcom/qdsp6/q6apm.c b/sound/soc/qcom/qdsp6/q6apm.c
index 970b08c89bb3..069048db5367 100644
--- a/sound/soc/qcom/qdsp6/q6apm.c
+++ b/sound/soc/qcom/qdsp6/q6apm.c
@@ -747,13 +747,22 @@ static int apm_probe(gpr_device_t *gdev)
 
 	q6apm_get_apm_state(apm);
 
-	ret = devm_snd_soc_register_component(dev, &q6apm_audio_component, NULL, 0);
+	ret = snd_soc_register_component(dev, &q6apm_audio_component, NULL, 0);
 	if (ret < 0) {
 		dev_err(dev, "failed to register q6apm: %d\n", ret);
 		return ret;
 	}
 
-	return of_platform_populate(dev->of_node, NULL, NULL, dev);
+	ret = of_platform_populate(dev->of_node, NULL, NULL, dev);
+	if (ret)
+		snd_soc_unregister_component(dev);
+
+	return ret;
+}
+
+static void apm_remove(gpr_device_t *gdev)
+{
+	snd_soc_unregister_component(&gdev->dev);
 }
 
 struct audioreach_module *q6apm_find_module_by_mid(struct q6apm_graph *graph, uint32_t mid)
@@ -820,6 +829,7 @@ MODULE_DEVICE_TABLE(of, apm_device_id);
 
 static gpr_driver_t apm_driver = {
 	.probe = apm_probe,
+	.remove = apm_remove,
 	.gpr_callback = apm_callback,
 	.driver = {
 		.name = "qcom-apm",
-- 
2.47.3


