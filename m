Return-Path: <stable+bounces-227109-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id B4RWEtXcumk3cwIAu9opvQ
	(envelope-from <stable+bounces-227109-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 18:11:49 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F1A222BFF81
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 18:11:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C30D0324763D
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 16:27:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86DA33F23C9;
	Wed, 18 Mar 2026 16:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=imgtec.com header.i=@imgtec.com header.b="s2Cj6nLi"
X-Original-To: stable@vger.kernel.org
Received: from mx08-00376f01.pphosted.com (mx08-00376f01.pphosted.com [91.207.212.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9EFB4035DE;
	Wed, 18 Mar 2026 16:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.86
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773849620; cv=none; b=P8iYQowMtoEzkt2P7CmnKMKYfGKthQw2gmDCx4k8adLBZ3qQo4sdtAVnJrOUd8sazaUS7v39fCp/FJObm9taaukVgyZyHvR/fQQuJzpE40kHtWYKVGLvMjEzZlPtkmC/D/bH5bMqBP3Pb//yLVZHWGczUmLK19aUQUqHqtslsJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773849620; c=relaxed/simple;
	bh=HbNU6opN3mtELQZsusPWAIOs+NE+zIWaeh15R//swa4=;
	h=From:To:CC:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=r0E7Gse2agjRkcLfGOGDqd1ZGUO85eFP2oHgGrbHk6GrF9N2grD0D2tjiPxPEl/V0B82zGFrPVKBDW6PQ26x3YRQcoiMSE6RBOdBc37w/OeasMC9FEsJWcwUpLdbCly2LbWcevQQXVLZZi/mYDUIeagJEu7cYNlZaz37vkRFiok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=imgtec.com; spf=pass smtp.mailfrom=imgtec.com; dkim=pass (2048-bit key) header.d=imgtec.com header.i=@imgtec.com header.b=s2Cj6nLi; arc=none smtp.client-ip=91.207.212.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=imgtec.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=imgtec.com
Received: from pps.filterd (m0168888.ppops.net [127.0.0.1])
	by mx08-00376f01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62I5gDHv2630875;
	Wed, 18 Mar 2026 15:59:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=dk201812; bh=u
	HOoqbN6ZLcpo0DSRygxw21OeUrYvqcpbnfBg4e9KoU=; b=s2Cj6nLi424thIf2A
	vfijdQJqAKH1DeSfew5rDugJ6EnC9Pnu2lLZPNsQVstIoWtOY3kpskaUJA7cRqR1
	cUnqbOZU3brcdu0NSppxUmEFc7oK2GouqmfSF6YLA9ev5f9bWoXuDURzHYoZjbq4
	ilVFm0QwxvzRvVqGp4ntm6U0IA1DsEONnVktXTrqYuIbGvxoq42+5i6Zc1rg/AGd
	9t4TbclV2nQN+YlqL0g2Ap5zbHHze/Nm+G4J3VNhMZ5Xw9YPW+/Im35Sghthq7ME
	yy5ziXzWwBgQVtsDWKIztunqjAE0ImN/JkkJNhGNhvPWxKy88g2udGsS6BericY8
	5UBDw==
Received: from hhmail02.hh.imgtec.org (83-244-153-141.cust-83.exponential-e.net [83.244.153.141])
	by mx08-00376f01.pphosted.com (PPS) with ESMTPS id 4cvxtt3dfa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Mar 2026 15:59:48 +0000 (GMT)
Received: from HHMAIL03.hh.imgtec.org (10.44.0.121) by HHMAIL02.hh.imgtec.org
 (10.100.10.20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 18 Mar
 2026 15:59:48 +0000
Received: from
 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa
 (172.25.4.249) by HHMAIL03.hh.imgtec.org (10.44.0.121) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 18 Mar 2026 15:59:47 +0000
From: Matt Coster <matt.coster@imgtec.com>
To: Frank Binns <frank.binns@imgtec.com>,
        Brajesh Gupta
	<brajesh.gupta@imgtec.com>,
        Alexandru Dadu <alexandru.dadu@imgtec.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard
	<mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie
	<airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Alessio Belle
	<alessio.belle@imgtec.com>
CC: <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        <stable@vger.kernel.org>
In-Reply-To: <20260309-fix-soft-reset-v1-1-121113be554f@imgtec.com>
References: <20260309-fix-soft-reset-v1-1-121113be554f@imgtec.com>
Subject: Re: [PATCH] drm/imagination: Fix deadlock in soft reset sequence
Message-ID: <177384958720.4032.11431279489285692576.b4-ty@imgtec.com>
Date: Wed, 18 Mar 2026 15:59:47 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Authority-Analysis: v=2.4 cv=L9YQguT8 c=1 sm=1 tr=0 ts=69bacbf4 cx=c_pps
 a=AKOq//PuzOIrVTIF9yBwbA==:117 a=AKOq//PuzOIrVTIF9yBwbA==:17
 a=Ylr_HOfL8O8A:10 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=kQ-hrUj2-E3RCbRHssb7:22 a=qZQ2PDNLMSdLoqI-hfl9:22
 a=r_1tXGB3AAAA:8 a=lxhOV1slj-FFl-G3NfkA:9 a=QEXdDO2ut3YA:10
 a=t8nPyN_e6usw4ciXM-Pk:22
X-Proofpoint-ORIG-GUID: US88TL8G5PEt11ouVcbCwyDVSLW7LX_e
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE4MDEzNiBTYWx0ZWRfX/EEhPPGq64UV
 B/55BdLPQYlJTxWfFU7/xlP3F5jFCSwvvpIpncOryFyDrd9DWZc65+t+a4kbSp8N49d78npSrS1
 jn++zezFug/E0vPJ0LEIxvAjI7qTT3yhjuqFfcAVXWl/BP8SVPGYhxYsimuIfQSRWzLTaz12BZk
 kXkmnbte/jf3GLyzVnWRNBxJCStZu0kH2neiC8ARt3K74RgrxK2mx/QV8Bt/yVeDakncCfWWzVW
 sppKis8qNr9BW1L1p+P9YmjxrafsJKcd/SHnmH6we9K9DzmW4sMYT79dLfKuin8k7MCapoLPhEt
 oSLKC0HIiZtpQd8EdBczbU38GUgBviAvQ7eRC4kdOlKhXWHWQON90Ii5h+8H54wc773PCJ1KkQn
 fvKuBBuTf8uOGJXwN4bdyYZ0gUsonZqKHMXShspofAUIObYWddKCXT6yZ/cVNpEbWF+jcye1rSF
 uk7I27CetZJgdAwXQqA==
X-Proofpoint-GUID: US88TL8G5PEt11ouVcbCwyDVSLW7LX_e
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[imgtec.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[imgtec.com:s=dk201812];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,imgtec.com:dkim,imgtec.com:email,imgtec.com:mid];
	TAGGED_FROM(0.00)[bounces-227109-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[imgtec.com,linux.intel.com,kernel.org,suse.de,gmail.com,ffwll.ch];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	DKIM_TRACE(0.00)[imgtec.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[matt.coster@imgtec.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: F1A222BFF81
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On Mon, 09 Mar 2026 15:23:48 +0000, Alessio Belle wrote:
> The soft reset sequence is currently executed from the threaded IRQ
> handler, hence it cannot call disable_irq() which internally waits
> for IRQ handlers, i.e. itself, to complete.
> 
> Use disable_irq_nosync() during a soft reset instead.
> 
> 
> [...]

Applied, thanks!

[1/1] drm/imagination: Fix deadlock in soft reset sequence
      commit: a55c2a5c8d680156495b7b1e2a9f5a3e313ba524

Best regards,
-- 
Matt Coster <matt.coster@imgtec.com>


