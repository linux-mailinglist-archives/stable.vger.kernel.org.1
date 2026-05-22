Return-Path: <stable+bounces-253763-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CHB2Ko9AEGrzVAYAu9opvQ
	(envelope-from <stable+bounces-253763-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 13:39:59 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 147A65B3235
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 13:39:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BFE26303FFFF
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 11:33:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19B2D3E8670;
	Fri, 22 May 2026 11:33:23 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 986733E9C03;
	Fri, 22 May 2026 11:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779449602; cv=none; b=JNxGSdVtTpCCH4p/PQJT4TklBbVaX55lfbqgw3FzfQt52QwYCKOJcB7qa9n+rLZKJR+4H+zxVAhde/NS0a+UBy4RrHhFgLTE/CdCZYlD3Y7z/Ja6QvWio9YAUGFxN7+jYqizRNj4/G46sbbeexPv1FkF2WDax2ifJcuEn1AgPO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779449602; c=relaxed/simple;
	bh=rlqtDav4sO5EQ1FPclwSiqn0VMzw7ZydNkBbvagBbXk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EEZ7h3p+LGOVUQL0ZcHqVisU3RYO+jtVCi3LpFikG9QZ0KGnq+wi0juas2+DnYCTw0S1GLIqPqt5CE/jfO/w3D1d5I94VJ2rTPjA/ALbGVlMGLMzWcVS3BEgNYAVNbktQ5AW+W9/ziEFiXxJ/sBDOxTif14/+baBxh9hihYXduc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from edelgard.fodlan.icenowy.me (unknown [112.94.100.115])
	by APP-01 (Coremail) with SMTP id qwCowAAHsm30PhBqUL4pEQ--.4624S2;
	Fri, 22 May 2026 19:33:09 +0800 (CST)
Message-ID: <36c9f600659923045c84e59c7a3b61e29cce1013.camel@iscas.ac.cn>
Subject: Re: [PATCH v3] drm/loongson: Use managed KMS polling
From: Icenowy Zheng <zhengxingda@iscas.ac.cn>
To: Myeonghun Pak <mhun512@gmail.com>, dri-devel@lists.freedesktop.org
Cc: Thomas Zimmermann <tzimmermann@suse.de>, Sui Jingfeng	
 <suijingfeng@loongson.cn>, Jianmin Lv <lvjianmin@loongson.cn>, Qianhai Wu	
 <wuqianhai@loongson.cn>, Huacai Chen <chenhuacai@kernel.org>, Mingcong Bai	
 <jeffbai@aosc.io>, Xi Ruoyao <xry111@xry111.site>, Maarten Lankhorst	
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-kernel@vger.kernel.org, 	stable@vger.kernel.org, Ijae Kim
 <ae878000@gmail.com>, Huacai Chen	 <chenhuacai@loongson.cn>
Date: Fri, 22 May 2026 19:33:08 +0800
In-Reply-To: <20260513065706.23803-1-mhun512@gmail.com>
References: <20260513065706.23803-1-mhun512@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID:qwCowAAHsm30PhBqUL4pEQ--.4624S2
X-Coremail-Antispam: 1UD129KBjvJXoW7uw4ktw13Gr48KFy5Ar47Jwb_yoW8GF4DpF
	W3G3sxtFyUGrn8CF4qg34xXF1xuaykJa43CrsxJ397uw1qya4fWr1xtF4Yg3WDJrWY9F4F
	yFyqvr1Skw1UJaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvqb7Iv0xC_Cr1lb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4
	A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IE
	w4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMc
	vjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwACI402YVCY1x02628vn2kIc2xKxwCY
	1x0262kKe7AKxVW8ZVWrXwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8Jw
	C20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAF
	wI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjx
	v20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2
	jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0x
	ZFpf9x07jaXdbUUUUU=
X-CM-SenderInfo: x2kh0wp0lqwv3d6l2u1dvotugofq/
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[iscas.ac.cn];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com,lists.freedesktop.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253763-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[suse.de,loongson.cn,kernel.org,aosc.io,xry111.site,linux.intel.com,gmail.com,ffwll.ch,vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhengxingda@iscas.ac.cn,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.994];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[loongson.cn:email,iscas.ac.cn:mid,iscas.ac.cn:email,suse.de:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 147A65B3235
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

=E5=9C=A8 2026-05-13=E4=B8=89=E7=9A=84 15:57 +0900=EF=BC=8CMyeonghun Pak=E5=
=86=99=E9=81=93=EF=BC=9A
> lsdc_pci_probe() initializes KMS polling before setting up vblank
> support,
> requesting the IRQ and registering the DRM device. If any of those
> later
> steps fails, probe returns without finalizing polling. The driver
> also
> never finalizes polling on regular removal.
>=20
> Use drmm_kms_helper_poll_init() so polling is tied to the DRM device
> lifetime and automatically finalized on probe failure and device
> removal.
>=20
> This issue was identified during our ongoing static-analysis research
> while
> reviewing kernel code.
>=20
> Fixes: f39db26c5428 ("drm: Add kms driver for loongson display
> controller")
> Cc: stable@vger.kernel.org
> Co-developed-by: Ijae Kim <ae878000@gmail.com>
> Signed-off-by: Ijae Kim <ae878000@gmail.com>
> Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
> Acked-by: Jianmin Lv <lvjianmin@loongson.cn>
> Reviewed-by: Huacai Chen <chenhuacai@loongson.cn>
> Signed-off-by: Myeonghun Pak <mhun512@gmail.com>

Reviewed-by: Icenowy Zheng <zhengxingda@iscas.ac.cn>

Thanks,
Icenowy

> ---
> Changes in v3:
> - Capitalize the subject as suggested by Huacai Chen.
> - Add Reviewed-by and Acked-by tags.
>=20
> Changes in v2:
> - Switch to drmm_kms_helper_poll_init() as suggested by Icenowy Zheng
> =C2=A0 and Thomas Zimmermann instead of adding manual cleanup paths.


