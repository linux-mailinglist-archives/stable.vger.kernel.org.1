Return-Path: <stable+bounces-244204-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aIo/MhER+mmfIwMAu9opvQ
	(envelope-from <stable+bounces-244204-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 17:47:29 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 65EBA4D087A
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 17:47:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BBA55303ED52
	for <lists+stable@lfdr.de>; Tue,  5 May 2026 15:43:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D2A1481FCB;
	Tue,  5 May 2026 15:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.in header.i=shivamkalra98@zohomail.in header.b="TNE83Yqh"
X-Original-To: stable@vger.kernel.org
Received: from sender-pp-o91.zoho.in (sender-pp-o91.zoho.in [103.117.158.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFAED363C50;
	Tue,  5 May 2026 15:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=103.117.158.91
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777995679; cv=pass; b=p3jJleuHfwrYv7DapckmrPcrT7It+VcjZeqKwYl9CKHggynNDIpX02t5Oj3yWGJmAL9VmpymIZLD1eOd+TrJ+/0WBpJs4ERwRvmLamvGT4brAkXAyXlh6VkZ1a53QRkEcQXloOo+JTyL3RzCUXnatO08tEGTCrMwaGBCwVvH+cU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777995679; c=relaxed/simple;
	bh=u+Yyd+Hktqm9ir3pA2ApM7zVK4bFiCbYz1r7rIj14nQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q4G/8SNqxxJ8OHngX/XkYE+P6/ne1/vzyG4YaW8rp7Ws6G+GRsmzWanEzYLMoYYysPsrQCNxW0gYfnntBQRRDa4eVvpAPdNYZ0N94fyeT9Fl9bPJHUDnGD6HJdbWq1yyxmOU4FGRx1Xc8OksGM+2neSltK3x5FQ+uEBiTBqH9P4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.in; spf=pass smtp.mailfrom=zohomail.in; dkim=pass (1024-bit key) header.d=zohomail.in header.i=shivamkalra98@zohomail.in header.b=TNE83Yqh; arc=pass smtp.client-ip=103.117.158.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.in
ARC-Seal: i=1; a=rsa-sha256; t=1777995654; cv=none; 
	d=zohomail.in; s=zohoarc; 
	b=LD4y0MJUCAB2TgK3JLqz77F/PdOYQUGh3dxkUUHbusb8Or7HMeN2XgG2ROrgv5vMn8XwfE3Wuco83AnFqzOg2oXvuQ5BdABaAHofE+f8aYV9lFs0hA2acCWrO2hwpGnSBqVeUNoK1jCmLjYmb06BDDLLi2NO7uSSRKcY/QIrVFk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.in; s=zohoarc; 
	t=1777995654; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=vjvCkedAYaK1ibuLxzlrmeEb/8iHLMyN/u8hH6wq9Ms=; 
	b=NSMYrzMhOo6i0hTPtRCjmM7rtxcBTCSaPqvPEnhcV22GL/7m62uL8dFDxtFOujH6Dms4ui13pCCVAg/IKxYMn8cnygAervD+GFejxArAGbsm1eJRE8sZfG5uumVGeHyu20aCmVpzNsACy33k1Eo4V/POIqzut67Q1BLuFLeDYtQ=
ARC-Authentication-Results: i=1; mx.zohomail.in;
	dkim=pass  header.i=zohomail.in;
	spf=pass  smtp.mailfrom=shivamkalra98@zohomail.in;
	dmarc=pass header.from=<shivamkalra98@zohomail.in>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1777995654;
	s=zoho; d=zohomail.in; i=shivamkalra98@zohomail.in;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=vjvCkedAYaK1ibuLxzlrmeEb/8iHLMyN/u8hH6wq9Ms=;
	b=TNE83Yqh117KiZDKT2QbRdG+7pZOCfqcvTgivVg8dGCQFJzY9m0OD+9fbxYn6ZvH
	bryaOYgI5k6PSCcYAadyZWUwU3muzQNp58/VkLt0s/Ja7wi53862jHIcma/32LaOLWV
	CZw+AdSD3ubTCd5U4ad3NOAwuNs+n05hV0D3/lHw=
Received: by mx.zoho.in with SMTPS id 1777995653687247.39096193810485;
	Tue, 5 May 2026 21:10:53 +0530 (IST)
Message-ID: <920f5a1a-921a-49e9-8942-249a0f6151e3@zohomail.in>
Date: Tue, 5 May 2026 21:10:53 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ACPI: video: force native backlight on HP OMEN 16 (8A44)
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260426-omen-16-backlight-fix-v1-1-62364f268ea6@zohomail.in>
 <e6ca711b-e134-426b-8df0-94323ac0f806@zohomail.in>
 <CAJZ5v0hQbBRR6HaJF6wiPqxoVrzEaNrK8WTY_YN52AQA2b+QGw@mail.gmail.com>
Content-Language: en-US
From: Shivam Kalra <shivamkalra98@zohomail.in>
In-Reply-To: <CAJZ5v0hQbBRR6HaJF6wiPqxoVrzEaNrK8WTY_YN52AQA2b+QGw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
X-Rspamd-Queue-Id: 65EBA4D087A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[zohomail.in,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[zohomail.in:s=zoho];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-244204-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shivamkalra98@zohomail.in,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[zohomail.in:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,zohomail.in:email,zohomail.in:dkim,zohomail.in:mid]

On 05/05/26 21:04, Rafael J. Wysocki wrote:
> On Tue, May 5, 2026 at 5:22 PM Shivam Kalra <shivamkalra98@zohomail.in> wrote:
>>
>> On 26/04/26 19:38, Shivam Kalra via B4 Relay wrote:
>>> From: Shivam Kalra <shivamkalra98@zohomail.in>
>>>
>>> The HP OMEN 16 Gaming Laptop (board name 8A44) has a mux-less hybrid
>>> GPU configuration with AMD Rembrandt (Radeon 680M) and NVIDIA GA104
>>> (RTX 3070 Ti). The internal eDP panel is wired to the AMD iGPU.
>>>
>>> When Nouveau loads without GSP firmware, the ACPI video backlight
>>> device (acpi_video0) gets registered alongside the native AMD
>>> backlight (amdgpu_bl2). In this state, writes to amdgpu_bl2 update
>>> the software brightness value but fail to change the physical panel
>>> brightness.
>>>
>>> Force native backlight to prevent acpi_video0 from registering.
>>> Confirmed that booting with acpi_backlight=native resolves the issue.
>>>
>>> Cc: stable@vger.kernel.org
>>> Signed-off-by: Shivam Kalra <shivamkalra98@zohomail.in>
>>> ---
>>> This patch adds a DMI quirk to force native backlight control on the
>>> HP OMEN 16 Gaming Laptop (board name 8A44), which has a mux-less
>>> hybrid GPU configuration with AMD Rembrandt (680M iGPU) and NVIDIA
>>> GA104 (RTX 3070 Ti).
>>> On this laptop the internal eDP panel is wired to the AMD iGPU. The
>>> amdgpu driver registers amdgpu_bl2 as the native backlight device.
>>> When the Nouveau driver is loaded without GSP firmware (as is the
>>> case on v6.17 where GSP is not the default for Ampere GPUs), writes
>>> to amdgpu_bl2 fail silently — the brightness sysfs value updates
>>> but the physical panel brightness does not change.
>>> Testing:
>>> - Tested on HP OMEN 16 with AMD Ryzen 9 6900HX + NVIDIA RTX 3070 Ti.
>>> - On v6.17, without this quirk, brightness control is broken.
>>> - On v6.17, booting with acpi_backlight=native restores correct
>>>     brightness control. This patch applies that workaround
>>>     automatically via DMI match.
>>> - On v6.18+, the issue does not reproduce because commit
>>>     e0ed674acbac ("drm/nouveau: Remove DRM_NOUVEAU_GSP_DEFAULT
>>>     config") made GSP firmware the default for Ampere, which avoids
>>>     the ACPI conflict entirely.
>>> I have only tested this on v6.17 and v7.0. I am leaving it to the
>>> stable/LTS maintainers to determine whether this quirk should be
>>> backported, as I have not verified the stability of the GSP firmware
>>> path on intermediate releases.
>>>
>>> Thanks,
>>> Shivam Kalra
>>> ---
>>>    drivers/acpi/video_detect.c | 8 ++++++++
>>>    1 file changed, 8 insertions(+)
>>>
>>> diff --git a/drivers/acpi/video_detect.c b/drivers/acpi/video_detect.c
>>> index 0a3c8232d15d..458efa4fe9d4 100644
>>> --- a/drivers/acpi/video_detect.c
>>> +++ b/drivers/acpi/video_detect.c
>>> @@ -916,6 +916,14 @@ static const struct dmi_system_id video_detect_dmi_table[] = {
>>>                DMI_MATCH(DMI_PRODUCT_NAME, "82K8"),
>>>                },
>>>        },
>>> +     {
>>> +      .callback = video_detect_force_native,
>>> +      /* HP OMEN Gaming Laptop 16-n0xxx */
>>> +      .matches = {
>>> +             DMI_MATCH(DMI_SYS_VENDOR, "HP"),
>>> +             DMI_MATCH(DMI_PRODUCT_NAME, "OMEN by HP Gaming Laptop 16-n0xxx"),
>>> +             },
>>> +     },
>>>
>>>        /*
>>>         * x86 android tablets which directly control the backlight through
>>>
>>> ---
>>> base-commit: 27d128c1cff64c3b8012cc56dd5a1391bb4f1821
>>> change-id: 20260425-omen-16-backlight-fix-73fb8bc4a2b9
>>>
>>> Best regards,
>>> --
>>> Shivam Kalra <shivamkalra98@zohomail.in>
>>>
>>>
>> Hey,
>>
>> A gentle thread bump. If you have any suggestions let me know.
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=4b506ea5351a1f5937ac632a4a5c35f6f796cc41
> 
> It looks like I have not responded to the patch, sorry about that.
Thank you

