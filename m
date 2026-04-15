Return-Path: <stable+bounces-238004-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mKXAH2Pu3mnmMgAAu9opvQ
	(envelope-from <stable+bounces-238004-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 03:48:19 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id EBE2D3FF905
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 03:48:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 62E54308382E
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 01:48:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D84163054EB;
	Wed, 15 Apr 2026 01:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XYukfGTh"
X-Original-To: stable@vger.kernel.org
Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64ED0224AF7
	for <stable@vger.kernel.org>; Wed, 15 Apr 2026 01:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776217691; cv=pass; b=R6BdjtTOLpz8hbML2wa5qdT04rv2GdymUM1ash+Qeg8qEE+VJ+0dOwybqLYbyO/JmwFItucF7JrohgVH8KiAHaDuliIo2E/BOGpwtVOhjZjw7l8iGHIpXvH6LhV+7TBWETtBOKW+zukeO5YkofP7gaVu3N++jVp6yT2fsppKPBc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776217691; c=relaxed/simple;
	bh=0RbwgasN3GJughcy4kp4J1oBaADm4wlXCXi8OGgl3cg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KkCXTXMc+bPABbRJSzvsTzrWnPYliNYaf+RsX/9O7UY1vwmsLGksGo7TQ0mRhPNDtGIbEwU/jDOWL7e9W7wG6lIwXg/xs0QRMzOs8Pdb/aSLtS1CIOeFpay0zTb2S7d8ERm1Fo8PlYVeJ6mX1M+cfbLboNtZdcNKNSK2EBRUQTY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XYukfGTh; arc=pass smtp.client-ip=74.125.224.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-6501418152cso5890797d50.0
        for <stable@vger.kernel.org>; Tue, 14 Apr 2026 18:48:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776217689; cv=none;
        d=google.com; s=arc-20240605;
        b=OQ3rEXF0pa3HUgn1nsA2PpKoktik84w4n5zUJJIXpO4o4OFYn/MN8ERe6KdEhS+xCj
         Gbdx93or+1Hceofv8GS2IOfxgrwo1gohp74bLUaGFpHqmAWV21vXDmpf9jHMxHMG7f8H
         63AtspVBvL05W8Ip/EYCxOzVPjg7L+ZzVKdyttnMnS5nhUJngQx40jSC1Hl1ALjcwnz+
         MiZ26kthXqQYlhksgRujLRFW6/Ik3xnd8B1NuR/ExI0C053Zed8tpXoZok3Yd1TMqsIT
         YNezkTRyp39SgV+t1JdvwkOInveHXtZcsYWiGPvfkc61b/iGZuFfswao0iXODvJsoVdR
         5DpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=37f+UWexUmjb2nKwNdsKiYaV71EelvYBwijtZJ1ZH4I=;
        fh=AdZ1I/zyUiBca/JDRQ+KF5Pllq+9ae485zoHqJGUc+8=;
        b=GmRRJ3LKb1cAUUzp2ohY4ijUMH4xucvFIr6dZ9bt4tuyhZq6Dm5S+PByWFd9Na/xQl
         cw1yTrrYyVht0ZluGljLd7ubHt0ipZrnnAwLVvsI/jp6RPpz6R0X8gl7KwQ5TsDBiWpo
         ws9gCsW9CQK4fxw5fgEn714qY+lN6uxmeX+t/vPJ6ftXUkYSG3Knm/NGt+AOdtdP0LVB
         kuwtG2SXTvRZW2X3qGS2Z6VBysDuq5s8AqcrWORPPgHyC9Oqlha5J1dZg87OpEtI+WmS
         maWgvp69VI3fgjPd/e97a0cZcYMVXF3mlLBYkVOF+S721nTGO17MdGdOgymnN7IH4pMj
         wWbg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776217689; x=1776822489; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=37f+UWexUmjb2nKwNdsKiYaV71EelvYBwijtZJ1ZH4I=;
        b=XYukfGThwNMgWkOboyuO7SNwewy4WFNubrYWynukiMbLFq5kwEVvRZJsIh8UwDDkYA
         PUxvZpkb/Nn8DryCZrNkeBjuRzUTPHYh+upvTpYUzQQpt5rVJzUHMs/aiBsnwCPnMBKH
         0PZXQt5JGO4v8OgAkx+evLc98iKJs+joylvJztSGfRJjJWI5vdOQ7pxlkHi36WZX+QZe
         fILBGFiFvJDTQUoSVqpdO3O4oEK7f32mAMDIC/nyDYYbgnhJpaTiyUu/HRSylivE9Jjg
         fKHdm6QhySsdIENyz2RAI+3EXbqKQk0EqSrzI491SpNQbhwqyiNpwf4FGQUeMULIFllO
         jL1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776217689; x=1776822489;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=37f+UWexUmjb2nKwNdsKiYaV71EelvYBwijtZJ1ZH4I=;
        b=q4LxMwwAR/7hanqQ+TuySNzJxkcBC91kmKQF0EyQYMD9p7giSPhliruaItHYZrtrrj
         f7eKLMIoYPCNRgP4IUIdzxQkF9ny+JQ590uS+2vzVe0cMCvUoJ4sgdNv2w0sQ2NIUOIt
         D0T+n0X0xVhgZu9DGPYfsnJnhm8GkA40Wn6jgcxqmXCZHyY9Bq18Z6RaKYTa2PVepNo0
         3OKEfFEEY7eoaTW3kMKgGBEbiUnwpkdJV1OL35AAuGPhnUqcvhy5ueVYnF4AdlihrzD3
         eztISDT2bpSJSEsGekB26bRN8N4NlWuDOwINqS+d3AZbIBNB7yRVPNHFDk0Yg9oD/eei
         ZvFg==
X-Forwarded-Encrypted: i=1; AFNElJ83FmknHYErmADy0XK3HbR33IJoKBMKPYK+K+vcyPAA5pdS3pRbnHmX5SGLEmx8F9s5NpOk1qs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZ4r5EWg7szz0cBTwgZbGG+FTfy4sKYas26kyX85F4GJwz7yNc
	I1ygGFgIspmelinZPjj7hatubTFyTlHZzz3Q4+Z4ZqWGxzbdvPX1pzyfQyil9DQY4WPL5Twa5DX
	XPs86OCSN3S+Us7AJ1hxkbIweTUSC2SI=
X-Gm-Gg: AeBDieupdqytJ1iw19DfR8jL2kGztqV9l6orfKta2NKKIkQ/LMXR7XQoRCqPiwdx56r
	QZp+kDrK9wdZ0Lclq6PDbPwiZbCfpZ36KqhRFkSj+o37DjpLlydYThPwus6PmSN0v50Zx37fAji
	3vpK2lG2tfoJsg65h0FKFAkbPiItEP+aNcO9p0TnhDLJmIRTKiK/WhYdHo+ESqSNtc5azTL0D2f
	7RnRirZdGH5fNNMVnYmypv+xYYneQcIWRTpqY8CPyVh+naqKaG7QRqzUsS5BPP9H53Z+6rd4wOP
	jT2R7OkTk9Z/jT9aA/UkRdhPH1nh84c=
X-Received: by 2002:a05:690e:c4e:b0:651:c203:4c47 with SMTP id
 956f58d0204a3-651c203521emr12060568d50.35.1776217689415; Tue, 14 Apr 2026
 18:48:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260413112030.2694563-1-lgs201920130244@gmail.com> <5da15f31-e9af-4f8d-82fd-eac29a6d98f6@intel.com>
In-Reply-To: <5da15f31-e9af-4f8d-82fd-eac29a6d98f6@intel.com>
From: Guangshuo Li <lgs201920130244@gmail.com>
Date: Wed, 15 Apr 2026 09:47:50 +0800
X-Gm-Features: AQROBzCCUNU9uahs4IXfUesDYaPErWVj8Mz6N5ygwqO9C1cJWWLC0UM8TIXIpcE
Message-ID: <CANUHTR8uNVWR48xs90s+MtGQ6J-1j5R0+64MKVGin0cf-FjRWA@mail.gmail.com>
Subject: Re: [Intel-wired-lan] [PATCH v2] dpf: fix UAF and double free in
 idpf_plug_vport_aux_dev() error path
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>, 
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Joshua Hay <joshua.a.hay@intel.com>, 
	Tatyana Nikolova <tatyana.e.nikolova@intel.com>, Madhu Chittim <madhu.chittim@intel.com>, 
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-238004-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lgs201920130244@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[stable,netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: EBE2D3FF905
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Jacob,

Thanks for reviewing.

On Wed, 15 Apr 2026 at 05:03, Jacob Keller <jacob.e.keller@intel.com> wrote:
>
>
> This doesn't look right. The commit message analysis seems to match this
> fix from Greg KH:
>
> https://lore.kernel.org/intel-wired-lan/2026041432-tapestry-condition-22ff@gregkh/
>
> But the changes do not make any sense to me. It looks like a poorly done
> AI-generated "fix" which is not correct. Greg's version does look like
> it properly resolves this.
>
> > v2:
> >   - note that the issue was identified by my static analysis tool
> >   - and confirmed by manual review
> >
>
> What even is this change log?? I see that version was sent and everyone
> else was sane enough to just silently reject or ignore the v1...
>
> >  drivers/net/ethernet/intel/idpf/idpf_idc.c | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/net/ethernet/intel/idpf/idpf_idc.c b/drivers/net/ethernet/intel/idpf/idpf_idc.c
> > index 6dad0593f7f2..2a18907643fc 100644
> > --- a/drivers/net/ethernet/intel/idpf/idpf_idc.c
> > +++ b/drivers/net/ethernet/intel/idpf/idpf_idc.c
> > @@ -59,6 +59,7 @@ static int idpf_plug_vport_aux_dev(struct iidc_rdma_core_dev_info *cdev_info,
> >       char name[IDPF_IDC_MAX_ADEV_NAME_LEN];
> >       struct auxiliary_device *adev;
> >       int ret;
> > +     int adev_id;
> >
>
> You create a local variable here...
>
> >       iadev = kzalloc(sizeof(*iadev), GFP_KERNEL);
> >       if (!iadev)
> > @@ -74,11 +75,14 @@ static int idpf_plug_vport_aux_dev(struct iidc_rdma_core_dev_info *cdev_info,
> >               goto err_ida_alloc;
> >       }
> >       adev->id = ret;
> > +     adev->id = adev_id;
>
> adev_is is never initialized, so you assign a random garbage
> uninitialized value. This is obviously wrong and will lead to worse
> errors than the failed cleanup.
>
> I'm rejecting this patch in favor of the clearly appropriate fix from Greg.
>
> >       adev->dev.release = idpf_vport_adev_release;
> >       adev->dev.parent = &cdev_info->pdev->dev;
> >       sprintf(name, "%04x.rdma.vdev", cdev_info->pdev->vendor);
> >       adev->name = name;
> >
> > +     /* iadev is owned by the auxiliary device */
> > +     iadev = NULL;>          ret = auxiliary_device_init(adev);
> >       if (ret)
> >               goto err_aux_dev_init;
> > @@ -92,7 +96,7 @@ static int idpf_plug_vport_aux_dev(struct iidc_rdma_core_dev_info *cdev_info,
> >  err_aux_dev_add:
> >       auxiliary_device_uninit(adev);
> >  err_aux_dev_init:
> > -     ida_free(&idpf_idc_ida, adev->id);
> > +     ida_free(&idpf_idc_ida, adev_id);
> >  err_ida_alloc:
> >       vdev_info->adev = NULL;
> >       kfree(iadev);
>

You are right that the v2 patch as sent is incomplete. That was my
mistake when preparing/sending v2: it accidentally dropped the adev_id
= ret; assignment, which made that version incorrect.

For reference, the original v1 patch is here:

https://lkml.org/lkml/2026/3/21/421

In v1, adev_id was assigned from ret before use, so I believe that
particular uninitialized-variable issue was introduced in the v2
posting.

Sorry for the confusion caused by the broken v2 posting.

Thanks,
Guangshuo

