Return-Path: <stable+bounces-262234-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id dEo5M3PYJ2r43AIAu9opvQ
	(envelope-from <stable+bounces-262234-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 09 Jun 2026 11:10:11 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 97E1B65E1F1
	for <lists+stable@lfdr.de>; Tue, 09 Jun 2026 11:10:10 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=seu.edu.cn header.s=default header.b=AD7+HCMt;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-262234-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-262234-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=seu.edu.cn;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7FEC630A3F44
	for <lists+stable@lfdr.de>; Tue,  9 Jun 2026 09:03:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08C3B3F0A98;
	Tue,  9 Jun 2026 09:02:50 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-m49197.qiye.163.com (mail-m49197.qiye.163.com [45.254.49.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DC372E091E;
	Tue,  9 Jun 2026 09:02:44 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780995769; cv=none; b=kLDuuWmapMcqAujoHovQHDe528HZCnXwD7PT2kPpWMAEhgkltGH2TaSLiOLKGTEY3gg9ONUHnnWW+3BnJ/ykc8ty/IARdkyisnjkdW0gCObfsWXSWg8Pzh5bd9hGVlV76IIR6eDGMuskF2Tx5HkAxJ/sP6BT7SrL4/2XuqH9y7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780995769; c=relaxed/simple;
	bh=UmkP/nL3r38JTITNDMoUIrL43Ud/mv8TE/EbWihEuGU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pOOJdmGslESn9OSvm1R3n/VhoS3gXQ8dc6FZIO9KyBhm2WbkNSo2oO/nA13MiS+WxL5osGA7Tp/gvOD2Of6VoIDZNMwXkJvTyDmRxBGlmGccuHSnMxzGfp2QOy/FjoB7SFkcjV9H0609k1aKudGlTk3nuUyIewSHqn6OAkust6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=AD7+HCMt; arc=none smtp.client-ip=45.254.49.197
Received: from DESKTOP-SUEFNF9.taila7e912.ts.net (unknown [221.228.238.82])
	by smtp.qiye.163.com (Hmail) with ESMTP id 41a876c6e;
	Tue, 9 Jun 2026 16:57:26 +0800 (GMT+08:00)
From: Dawei Feng <dawei.feng@seu.edu.cn>
To: ttabi@nvidia.com
Cc: dakr@kernel.org,
	dawei.feng@seu.edu.cn,
	dri-devel@lists.freedesktop.org,
	jianhao.xu@seu.edu.cn,
	linux-kernel@vger.kernel.org,
	lyude@redhat.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	namcao@linutronix.de,
	nouveau@lists.freedesktop.org,
	simona@ffwll.ch,
	stable@vger.kernel.org,
	zilin@seu.edu.cn
Subject: Re: [PATCH] nouveau/firmware: fix memory leak on BL load failure
Date: Tue,  9 Jun 2026 16:57:29 +0800
Message-Id: <20260609085729.3786763-1-dawei.feng@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <0045b3583272df0b82f146fd96dee13d03377b4a.camel@nvidia.com>
References: <0045b3583272df0b82f146fd96dee13d03377b4a.camel@nvidia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9eab99d60503a2kunmd4cb5e84127d3d
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkaGEtCVk4YSklJSh9MHh1JGlYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlJSUpVSUlDVUlIQ1VDSVlXWRYaDxIVHRRZQVlPS0hVSktISk
	9ITFVKS0tVSkJLS1kG
DKIM-Signature: a=rsa-sha256;
	b=AD7+HCMty0xT7ukJ2iVq24XZZtBk3S/QiDWX6gpGVFjcPKiO7RmZE7dzKCP/i1ObA/sHrur+vKJnntauTebn7UK4kaZhgSBnpvDaCOC3pG1hOrsw5Ok03Ux6gPVAd2HoLcW8JJIC4/n1uvVMkY4LrxLMkFVDeukP++uXZW+UT0U=; c=relaxed/relaxed; s=default; d=seu.edu.cn; v=1;
	bh=PWKiJfHLAuY51AfkQhZeCWOGsOm5BCLCBnZ0+m/OIxk=;
	h=date:mime-version:subject:message-id:from;
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[seu.edu.cn,none];
	R_DKIM_ALLOW(-0.20)[seu.edu.cn:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-262234-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[dawei.feng@seu.edu.cn,stable@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:ttabi@nvidia.com,m:dakr@kernel.org,m:dawei.feng@seu.edu.cn,m:dri-devel@lists.freedesktop.org,m:jianhao.xu@seu.edu.cn,m:linux-kernel@vger.kernel.org,m:lyude@redhat.com,m:maarten.lankhorst@linux.intel.com,m:mripard@kernel.org,m:namcao@linutronix.de,m:nouveau@lists.freedesktop.org,m:simona@ffwll.ch,m:stable@vger.kernel.org,m:zilin@seu.edu.cn,s:lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dawei.feng@seu.edu.cn,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[seu.edu.cn:+];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 97E1B65E1F1

Hi, Timur,

On Fri, Jun 05, 2026 at 06:22:41PM +0000, Timur Tabi wrote:
> Ah yes, you're right.
>
> So now I think a better fix might be to have two different `blob`
> variables, so that there is no longer any confusion. Because right now,
> the nvkm_firmware_put() call at the end of the function releases a
> different `blob` depending on whether `bl` is NULL or not.
>
> What do you think about this:
>
>     nvkm_firmware_put(blob);
>     if (bl) {
>             const struct firmware *blob_bl;
>
>             ret = nvkm_firmware_load_name(subdev, bl, "", ver, &blob_bl);
>             if (ret)
>                     goto done;
>             ...
>             nvkm_firmware_put(blob_bl);
>             if (!fw->boot)
>                     ret = -ENOMEM;
>     } else {
>             fw->boot_addr = fw->nmem_base;
>     }
>
> done:
>     if (ret)
>             nvkm_falcon_fw_dtor(fw);
>
>     return ret;

Yes, using a separate pointer `blob_bl` for the bootloader firmware is a
cleaner approach. 

However, we must keep the final nvkm_firmware_put(blob) under the done
label. Moving it earlier would cause memory leaks in prior error paths
like nvkm_falcon_fw_ctor(), which jump directly to done. 

A safer approach is to manage blob_bl locally inside the if (bl) block,
while leaving the original blob cleanup at the end. 

What do you think about this:

        if (bl) {
                const struct firmware *blob_bl;

                ret = nvkm_firmware_load_name(subdev, bl, "", ver, &blob_bl);
                if (ret)
                        goto done;

                ...
                nvkm_firmware_put(blob_bl);
                if (!fw->boot)
                        ret = -ENOMEM;
        } else {
                fw->boot_addr = fw->nmem_base;
        }

done:
        if (ret)
                nvkm_falcon_fw_dtor(fw);

        nvkm_firmware_put(blob);
        return ret;

Regards,
Dawei

