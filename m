Return-Path: <stable+bounces-219135-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wBJ4N0lfnmmaUwQAu9opvQ
	(envelope-from <stable+bounces-219135-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 03:32:41 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 56FCD190EAD
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 03:32:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E156D304EF41
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 02:32:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9D932882DE;
	Wed, 25 Feb 2026 02:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="unejiNui"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4854822B8A6
	for <stable@vger.kernel.org>; Wed, 25 Feb 2026 02:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771986728; cv=pass; b=Rf3fwJEEGfPtIcJ1Psm4SzvwSDTiK25CsBnB4AzhMCyi1I5moBiQXdeMPazj4yMROenSQLZ3a2+zPoMSQQxO11wUGSummmTFqsVxOx89j4zSh4ghd2hzG9jbGk071cGuI2L8cl4eQB7YCKvPFjgxkavwVlkDGOtjeUf++A9OKQs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771986728; c=relaxed/simple;
	bh=HMllSNLX/5sTo6GERROO6GON0rCra4+CbtOSEvH9L5w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BU/cMNDBZNEsXANH0sofLyz1PWKEE4+jPFxk2NLkpVLPSA0UvfGSbo4rzz/ffPPJIE/YX9JW1KRPsKW7uRc4WjlBHjPp1jOQqU+n30d6aordvjdsrfiDkla3H2oM4SmdpRfawXn5dDqPR8dog2zgX+s6h78sKQxVK3rVlFFsPhc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xwf.google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=unejiNui; arc=pass smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xwf.google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-5069a785ed2so223651cf.1
        for <stable@vger.kernel.org>; Tue, 24 Feb 2026 18:32:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771986726; cv=none;
        d=google.com; s=arc-20240605;
        b=GE5xWajpjd8RCOV/xPU/fwq5AGmWOpw2LwZclFzu+XkrW2lkra3JvUblJb7FIu6LVS
         YJiK5IQIGcSlHqvVEHSpRnRp+l8VCQcuCOsYF8newk8Ha4b4PtkSGPBSKkDymFcyCdul
         P3ixrbpYOSeNC+Elch1+XWJ+WcI0Iq/BcwMmTklKuT+IWo580/ItNz5iA7amOxI+zs40
         2VznyiyBxj62XReN5kvVPLnc/iY5RiCylLQAqTEoUZ0XPQG42TNDibwrGYIYTKwjj+QQ
         j10pTfxaUxL6BmhB+NhVY5jIIms2jDrz29b15cM5wSvAE/VKHnRHKIDFMS9Tun//5hxL
         jF4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:dkim-signature;
        bh=/Oc0EL9P9H90t/kP213jAXvrzQURQZDfc9BINIduye0=;
        fh=PJdrvwNLseXrRrX3DJZv0sfpXgML5+xbEYRqUCyKFfc=;
        b=DS4dZct8irOXtj3gO3B85C6vcVVhVN6IUFF4LfckxQ/SRbUA6Sm56uF2QzlFT7vIyw
         MVwyzZpsfDPqhNSL1dI5xCFq/05//XthoFT1RoDGBhPxru//P5P0p8XoUFSvoADJVLrk
         jiybITidxT4ijJct+/CbuyPsfmgbthirgK7h/J4GFY/NmoH6Vaoojn4xdhOD33oeOKC0
         aFGWcA5mIw+FfaucfXm3fVTuaTpuQ7BMBsbkEbw/zOZBcJdJd4GdjhkRcPHmArW+pei1
         wMGoMfENBSrKtBHcMfsDo1bBklUgbe6VKSG5bhSpa/nwPJ4fVabAX6rMTnqUpNhXxAAh
         +Ntw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771986726; x=1772591526; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/Oc0EL9P9H90t/kP213jAXvrzQURQZDfc9BINIduye0=;
        b=unejiNui+bHysnuemKK2PptMSAUKcP6mXp7AJH6V5WCk+1VZDfYfC4X315bSzv7x5w
         +Sao94FGzB6cpIw2EGpgb7LNN7oHFkbseS291l+7zTyC3JEPPPB3dFk+AXmfFHexta0V
         cx5n7SpbAP6WsLpLjB0brqmdORN9peAChfWIky0qdw8Kis4JV8fvoxV5T2ix+R78Wt16
         jasAoz7CzoFOzx+DCPbL9tnGxiTZ9ul/SA0MWfdap39lDxj1G7JLT59c5ILqHOawLN/4
         IAe+c/o+wnARGPYF8JmknnF355xI+UdvdraM14RJUNvBhXAhEldX7RiaKpuluKsvM8dy
         hrmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771986726; x=1772591526;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/Oc0EL9P9H90t/kP213jAXvrzQURQZDfc9BINIduye0=;
        b=QCgGMgucxnFVjwUj7rWjgVxocbQBP/kNiUqCBwohfCo3ybKf1CUKqBB47WW0wAzqvv
         nrIcT9c+GKxsvEc7+aHIwavapKXb9/X2Y/y7/La39lF4+8eYWKE9zVe9K14111k9ZVRR
         /vwyvx8tH7KzaydfNivIx8aeBr3S7lA0eIlk4LHMSNSbnLIs9SJYNQx0UMiV9oW5IlwC
         Sfe6uMStx3EZhKqPwAdWOVTagHIMs6LakVaBapYG/Rr9apez5x1HZ9UOv+052w4u5V18
         CoEoIA5X6du79/m4OWei+G1+KFvKTFwzQwS4Pw1tgiPsRrxbmA/sy99GQ90YCZe0ECpE
         2EPA==
X-Forwarded-Encrypted: i=1; AJvYcCVE6AifacTH8CYy+i1vzurI+9fvL9TKOKob+f46hAZc/q3+RE6qTc8ey1lSGYDroJNe8h0GzwU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMhSdji3s/C71gzTTQR8paIEiyBdUXbetdZtsiq6ooX8lrTB80
	37rfhkF2mT4XiUxmkFpHNG8cv7VX2F62Z90deifpEcYVAEbI/drn2Ub1qm/t+Uy6G/zd9W3f0bV
	cw7xFNueWDa7oB+u8SiGyTFnisP+/IuXTDEsJPBu/
X-Gm-Gg: ATEYQzwawdX6bZ5EJPIyHhMnAVK6f/IEzqrmMAyVgKBP896bshQ0RgygCvtq1T9annW
	NlzQGbTQZk8oSohe0ZciU1zBw9xuetFxf1M70WgK6MyO1q0KBoWMJ2joB6SDDUfuafu4/zps0yz
	nORMcYjrINSs37GcSlUKnx1LuMwUhCQw1gYRQ1T2GdrywRiaU0sVosKX4g2lwGfYWf0aC4TpqT6
	hlRkeXtsRsPY0EspvUKir4G10kBciOWt6ZoAZRC//y715FAcdQhtLtMgFHrHfKGgBeWwzOrb9K8
	GZVthQ8mRbPVEoPtfoiLXlLnAi1v8avDL0SKYQ==
X-Received: by 2002:a05:622a:30e:b0:507:358a:2b22 with SMTP id
 d75a77b69052e-50738178b0bmr1176721cf.0.1771986725687; Tue, 24 Feb 2026
 18:32:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260224083955.1375032-1-hhhuuu@google.com> <50314bb4-1539-452d-86d6-47887a9603a7@rowland.harvard.edu>
In-Reply-To: <50314bb4-1539-452d-86d6-47887a9603a7@rowland.harvard.edu>
Reply-To: hhhuuu@xwf.google.com
From: "Jimmy Hu (xWF)" <hhhuuu@xwf.google.com>
Date: Wed, 25 Feb 2026 10:31:54 +0800
X-Gm-Features: AaiRm535jFf_Wd3ZgoopxvcP7tMlUs04xRpSxf28KxL1dbAIqD_-iutvqH8Q2q8
Message-ID: <CAJh=zj+qoLr40+sSMksRi5AG36GkO_kDk=axvPoEU76Md-NeCg@mail.gmail.com>
Subject: Re: [PATCH] usb: gadget: f_uvc: fix NULL pointer dereference during
 unbind race
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Dan Vacura <w36195@motorola.com>, 
	Xu Yang <xu.yang_2@nxp.com>, Frank Li <Frank.Li@nxp.com>, 
	Hans Verkuil <hverkuil+cisco@kernel.org>, linux-usb@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, badhri@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-219135-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hhhuuu@xwf.google.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable,cisco];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	HAS_REPLYTO(0.00)[hhhuuu@xwf.google.com]
X-Rspamd-Queue-Id: 56FCD190EAD
X-Rspamd-Action: no action

On Tue, Feb 24, 2026 at 11:47=E2=80=AFPM Alan Stern <stern@rowland.harvard.=
edu> wrote:
>
> On Tue, Feb 24, 2026 at 04:39:55PM +0800, Jimmy Hu wrote:
> > Commit b81ac4395bbe ("usb: gadget: uvc: allow for application to cleanl=
y
> > shutdown") introduced two stages of synchronization waits totaling 1500=
ms
> > in uvc_function_unbind() to prevent several types of kernel panics.
> > However, this timing-based approach is insufficient during power
> > management (PM) transitions.
> >
> > When the PM subsystem starts freezing user space processes, the
> > wait_event_interruptible_timeout() is aborted early, which allows the
> > unbind thread to proceed and nullify the gadget pointer
> > (cdev->gadget =3D NULL):
> >
> > [  814.123447][  T947] configfs-gadget.g1 gadget.0: uvc: uvc_function_u=
nbind()
> > [  814.178583][ T3173] PM: suspend entry (deep)
> > [  814.192487][ T3173] Freezing user space processes
> > [  814.197668][  T947] configfs-gadget.g1 gadget.0: uvc: uvc_function_u=
nbind no clean disconnect, wait for release
> >
> > When the PM subsystem resumes or aborts the suspend and tasks are
> > restarted, the V4L2 release path is executed and attempts to access the
> > already nullified gadget pointer, triggering a kernel panic:
> >
> > [  814.292597][    C0] PM: pm_system_irq_wakeup: 479 triggered dhdpcie_=
host_wake
> > [  814.386727][ T3173] Restarting tasks ...
> > [  814.403522][ T4558] Unable to handle kernel NULL pointer dereference=
 at virtual address 0000000000000030
> > [  814.404021][ T4558] pc : usb_gadget_deactivate+0x14/0xf4
> > [  814.404031][ T4558] lr : usb_function_deactivate+0x54/0x94
> > [  814.404078][ T4558] Call trace:
> > [  814.404080][ T4558]  usb_gadget_deactivate+0x14/0xf4
> > [  814.404083][ T4558]  usb_function_deactivate+0x54/0x94
> > [  814.404087][ T4558]  uvc_function_disconnect+0x1c/0x5c
> > [  814.404092][ T4558]  uvc_v4l2_release+0x44/0xac
> > [  814.404095][ T4558]  v4l2_release+0xcc/0x130
> >
> > The fix introduces a 'func_unbinding' flag in struct uvc_device to prot=
ect
> > critical sections:
> > 1. In uvc_function_disconnect(), it prevents accessing the nullified
> >    cdev->gadget pointer.
> > 2. In uvc_v4l2_release(), it ensures uvcg_free_buffers() is skipped
> >    if unbind is already in progress, avoiding races with concurrent
> >    bind operations or use-after-free on the video queue memory.
>
> Sorry if the answer to this question is obvious to anybody familiar with
> the driver...
>
> The patch adds a flag that can be accessed by two different tasks
> (disconnect and release).  Is there any synchronization to prevent these
> tasks from racing and accessing the new flag concurrently?
>
> Alan Stern

Hi Alan,

Thanks for pointing that out. You're right, the boolean flag lacks
proper synchronization for concurrent access.
I will submit a V2 patch using atomic bit operations to ensure memory
visibility and atomicity across tasks. The changes will include:
* Replacing 'bool func_unbinding' with 'unsigned long flags' in struct
uvc_device.
* Using clear_bit() in uvc_function_bind() to reset the state.
* Using set_bit() in uvc_function_unbind() to mark the unbinding phase.
* Using test_bit() in uvc_function_disconnect() and uvc_v4l2_disable()
for safe checks.

Does this approach look reasonable to you?

Best regards,
Jimmy

