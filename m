Return-Path: <stable+bounces-272982-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id cVloJSjLT2rSoQIAu9opvQ
	(envelope-from <stable+bounces-272982-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 09 Jul 2026 18:24:08 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B7947336CD
	for <lists+stable@lfdr.de>; Thu, 09 Jul 2026 18:24:08 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=collabora.com header.s=zohomail header.b="h+la/lxc";
	dmarc=pass (policy=none) header.from=collabora.com;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-272982-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-272982-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 994C7302B5AB
	for <lists+stable@lfdr.de>; Thu,  9 Jul 2026 16:24:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF0E84343F5;
	Thu,  9 Jul 2026 16:24:03 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from sender4-op-o11.zoho.com (sender4-op-o11.zoho.com [136.143.188.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1F1E3783DE;
	Thu,  9 Jul 2026 16:23:59 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783614242; cv=pass; b=i7NIw8g7KxNvXxT3+N+yu6R3KWWkAEBvXQPtdyxy0YW8KgOCGdn43CApbdLo10YHElYX6q+z0l6lk93saHA9h14WhDdY9blQtBmFVxE+IEl/uf+NVrGfjJhHs3Zvt5exzViWI8A2+IWTzM0IQkosdCZPn0wUIbN0du5yvWDk82U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783614242; c=relaxed/simple;
	bh=BBApX0PqsAOuNnIS3W4g8ASQYn99wRqfx5cOW2l60EY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AUZcfNn8koJPaQWXvIw0uzfKDnpnYwR7F3sDvitPamcEVVljHwLY6VjVCt3R3wuTu5GBFuUB8QvBaeCUqJX8qUq7TF2F4lkQ/XhuMxtIIBK6T9Xagqsm+hdXibUvBZEo0thq6BQd33qQnYInSkSdLtkT6NeIiuGxnAULqvW3VFU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b=h+la/lxc; arc=pass smtp.client-ip=136.143.188.11
ARC-Seal: i=1; a=rsa-sha256; t=1783614229; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=niRRZPQrz7T9Zk4CpSbMjy+G5SmXE5ukVbQBZlG3yh0LAInb4W6FvVV42AP0kic6et8FZXRpxFsVRWv8uszXkotC9VwF4Uwvo+G+wuXw1iBou49xRF82hIx6RPxtfZUnH4QkBR2qiX6UNUveDb1SY8TngvyUcazqs/uPWovAwJ8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1783614229; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=epF0rxB7lKg2IRD6abbcyUE44UYIuJo/f9yIkc845WQ=; 
	b=bbSCRqrpBlFFMjDXzJ8WiCam4UjId+wp6Ynyl1nQa5/6f2QCzXbvEyA/ecwKPbpzFu9C9iXR07XVkGU6yjPer7s+fTJe4u+LyFynh+iARgjFi9QHLJib+uPypXvEtlPBd32KWAxoYbcJX8VSVpH8Je7RAKKkYAvgX/uwOuphRr8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
	dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1783614229;
	s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=epF0rxB7lKg2IRD6abbcyUE44UYIuJo/f9yIkc845WQ=;
	b=h+la/lxcm6pcWpmugBmcJ7E9CK/fnTfWZKbbKZqHNRAfjau2jof0kwhT5lwbd+YZ
	v3n4GiIXt/y5atyn/5ZGDSfO8DaJCoaajTc8qqNnJ/1AXOKYBZltWOu5ehS2FHKwZqD
	n7c7djpnQqpcP1GivxvtIchSyLO1/GT7/IMD3uJQ=
Received: by mx.zohomail.com with SMTPS id 1783614227917726.9600571528584;
	Thu, 9 Jul 2026 09:23:47 -0700 (PDT)
Message-ID: <e9d5c9ee-88b1-4e9c-9999-74edbb2c59f3@collabora.com>
Date: Thu, 9 Jul 2026 19:23:43 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/virtio: Don't detach GEM from a non-created context
To: Yiwei Zhang <zzyiwei@google.com>
Cc: Jason Macnak <natsu@google.com>, David Airlie <airlied@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Gurchetan Singh <gurchetansingh@chromium.org>,
 dri-devel@lists.freedesktop.org, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260625170828.3335431-1-natsu@google.com>
 <7202d2dc-b6fe-440e-88b0-aefb26c38b86@collabora.com>
 <CAKT=dD=YecudFK1L9wJ22BO41qXt7V4Qm=nNQQiuwheKejoHdg@mail.gmail.com>
Content-Language: en-US
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <CAKT=dD=YecudFK1L9wJ22BO41qXt7V4Qm=nNQQiuwheKejoHdg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[collabora.com,none];
	R_DKIM_ALLOW(-0.20)[collabora.com:s=zohomail];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-272982-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[dmitry.osipenko@collabora.com,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:zzyiwei@google.com,m:natsu@google.com,m:airlied@redhat.com,m:kraxel@redhat.com,m:gurchetansingh@chromium.org,m:dri-devel@lists.freedesktop.org,m:virtualization@lists.linux.dev,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[collabora.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dmitry.osipenko@collabora.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,collabora.com:from_mime,collabora.com:email,collabora.com:mid,collabora.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2B7947336CD

On 7/7/26 22:01, Yiwei Zhang wrote:
> On Mon, Jun 29, 2026 at 2:39 PM Dmitry Osipenko
> <dmitry.osipenko@collabora.com> wrote:
>>
>> Hi,
>>
>> On 6/25/26 20:08, Jason Macnak wrote:
>>> Applies the same treatment as commit 7cf6dd467e87 ("drm/virtio:
>>> Don't attach GEM to a non-created context in gem_object_open()")
>>> to virtio_gpu_gem_object_close() to avoid trying to detach
>>> a resource that was never attached due to a context
>>> never being created when context_init is supported.
>>>
>>> Fixes: 086b9f27f0ab ("drm/virtio: Don't create a context with default param if context_init is supported")
>>> Cc: <stable@vger.kernel.org> # v6.14+
>>> Signed-off-by: Jason Macnak <natsu@google.com>
>>> ---
>>>  drivers/gpu/drm/virtio/virtgpu_gem.c | 14 ++++++++------
>>>  1 file changed, 8 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/virtio/virtgpu_gem.c b/drivers/gpu/drm/virtio/virtgpu_gem.c
>>> index 435d37d36034..66c3f6f74e9c 100644
>>> --- a/drivers/gpu/drm/virtio/virtgpu_gem.c
>>> +++ b/drivers/gpu/drm/virtio/virtgpu_gem.c
>>> @@ -139,13 +139,15 @@ void virtio_gpu_gem_object_close(struct drm_gem_object *obj,
>>>       if (!vgdev->has_virgl_3d)
>>>               return;
>>>
>>> -     objs = virtio_gpu_array_alloc(1);
>>> -     if (!objs)
>>> -             return;
>>> -     virtio_gpu_array_add_obj(objs, obj);
>>> +     if (vfpriv->context_created) {
>>> +             objs = virtio_gpu_array_alloc(1);
>>> +             if (!objs)
>>> +                     return;
>>> +             virtio_gpu_array_add_obj(objs, obj);
>>>
>>> -     virtio_gpu_cmd_context_detach_resource(vgdev, vfpriv->ctx_id,
>>> -                                            objs);
>>> +             virtio_gpu_cmd_context_detach_resource(vgdev, vfpriv->ctx_id,
>>> +                                                    objs);
>>> +     }
>>>       virtio_gpu_notify(vgdev);
>>>  }
>>
>> The following scenario still will be troubling:
>>
>> 1. vgdev->has_context_init = true
>> 2. virtio_gpu_gem_object_open() invoked, GEM created and not attached to ctx
>> 3. virtio_gpu_context_init_ioctl() invoked, now vfpriv->context_created
>> = true
>> 4. virtio_gpu_gem_object_close() will detach resource that wasn't attached
>>
>> Add obj->ctx_attached member to struct virtio_gpu_object. See
>> virtio_gpu_object_attach() that uses obj->attached, do the same for
>> virtio_gpu_cmd_context_attach_resource().
>>
>> --
>> Best regards,
>> Dmitry
> 
> Hi Dmitry,
> 
> WIth context_init, resource attach/detach is per-context based. So a
> simple obj->ctx_attached won't work. One would have to track in the
> guest context_init ctx for whether a bo has been attached or not.
> 
> Another option is to accept this patch and live with the case you
> mentioned. We can consider that "invalid" user behavior.

Indeed, obj->ctx_attached shouldn't work for a shared/exported BO. Will
think on it for a couple days more and then merge this version if no
better ideas will appear.

-- 
Best regards,
Dmitry

