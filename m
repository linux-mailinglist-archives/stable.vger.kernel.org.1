Return-Path: <stable+bounces-224881-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OLV+KuvesmncQQAAu9opvQ
	(envelope-from <stable+bounces-224881-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 16:42:35 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 27B48274BFC
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 16:42:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E67B0300A525
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 15:40:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7F673D1707;
	Thu, 12 Mar 2026 15:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FLbRxazJ"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC22C3C7DF4
	for <stable@vger.kernel.org>; Thu, 12 Mar 2026 15:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773330045; cv=pass; b=MN9VaCBq3xJmHaNDlt2jXfuv6nQxf0GWA6hGkcS5BnUBO+j84a8pI8x/ujWI3IZ2ePzqpgVizCULY8PPA1nJK0bBxIiY8JXmGsxwPNglDtJfG+uOq1arCU2J15268y1c73AdwfjfErpDnr7ioKJPLFqQPYoIXh0joHnvZZ0bq4I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773330045; c=relaxed/simple;
	bh=9U79XuSEDogMsEE6qxccDeqtvH3bBahfO34fvcv/Lvg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S0XfvHPBhqDvgamWbJamVGTPMdggkvqgB60TFDgfLuJQdaVVjbbhSZiqWyXWcdZbhfhv8QvL0mVeRSBIkza1vBAWwOFDwp8ASoCxJOsJrYRksrBfrFr7jxEqYbmqvqHrMXiKTKUfBv4s8GRh7Xiv0Vvv6A6SA7eLFn9YTIbEFOk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FLbRxazJ; arc=pass smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-89a1347051aso4398506d6.2
        for <stable@vger.kernel.org>; Thu, 12 Mar 2026 08:40:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773330043; cv=none;
        d=google.com; s=arc-20240605;
        b=VPO+kMzPKe6oSbjRPFkj9k5ap1F7deBObVYpK3OcWSKuS5RlehviWCCdZyETp5dK5/
         tGnZwAWIaVLvgC5r1dU8T+JC/OtqlYUkkLOUTT0Mbw0uecNS/WAZNmS3fHFoiDyp1Or6
         KkIyR34ZTqkmEcIbZE0JWsrl6BNcj7mNlWz3tRk4H9vetFirfVfdHva3GI9fDKXiiEZe
         T0M1VrG2sGtCdSLaqvcomHgWC0sKsu5P688Xh/8rjm0JoEDzzuaw+up6RUO0AgSEaaoy
         qkE2LYZzQajdN5r6BsvzWgemcd/UGCI2avifx6vFhLOQbe+xwuWb3DlSPBBTqAD9nhTW
         I1og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=pTMqddxceH06ae4/6PYanD/2oexQ8xHGkM95DOK/9Sw=;
        fh=3dXTq+dtyvgkwKakuJYG01hV6gROdkiuFzyl7FgvUcM=;
        b=TFvCh2ZhegeCqneTdU0Q1za+tY19D8VmmhJqEFc1J1Z/BEe3ktfmVcJaH+wPPw3eFc
         LuvsdGCwxF4lmt8dAhzmK6lAuLMOmTHu3Ui3F3I4XgwgFdQHyUMGWhwR+t30cDuhxZN8
         VIl3DKTUg9Uf5IhEfGbtwWg+4F7oXjs7i/pgaMSykLwTegoqbF1WfDS6x9RG7O2BjTnr
         QR7Pwxj+87kTDlJXfSAIR1Z8wPdwBbB08yQaYK0D1+fS+pVlTxpwOkORTInAHzKcsejZ
         UhOjDC8rpvvq3duyWwkZv1lJxfYH2Oq6kIslk0aCxMdGmpeOHTKLwy2X/MzI0tL4Sgrf
         IXxw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773330043; x=1773934843; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pTMqddxceH06ae4/6PYanD/2oexQ8xHGkM95DOK/9Sw=;
        b=FLbRxazJIzPZEV2sEZx9zrboFDwIn+alCWs5hskbczBtnRLe/otMlpIQowj+KltuzF
         dwUgUcaKyd71ghZv2xyO826u6NaTDLhL6g692D9sn40GRpRbWf4wxY1u0PYC6r9Ik4Ry
         PL4W/U1BRT4K9uf8AlbU3gXXgChiy81qi+81n+UZ4aDPM1gSsyaXSLC2SG7x89IQzJfM
         nDhckLHdULcBqGfdsC2Gy7+vslG/RbVkPU+GYhAx8+NS7nbyur/Z+wukqB/lP87FQ1hH
         xtYVq56q89qXqRAFw4xLuvrXf9l5XzAMxxcMAo5S3Cdi28+zM1w7WebovbE84O8OdspQ
         NZ/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773330043; x=1773934843;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pTMqddxceH06ae4/6PYanD/2oexQ8xHGkM95DOK/9Sw=;
        b=Oj1CTbiMXGcFuNeHoafYGqWQ2eBL3vior3Uqw7p2o6xpvk62aw0amqXMotqgTzI6Gz
         Q/SV3wmLozB5izGfwmFOifb4cfzi+qNrKHc9Pu7SQAUrQkI0taBZqSnv/8i4n+kdlv+k
         PkNJ1pSy0zm4x5FAGGUXlRvFqeKLdzBXYDejXnxIC3tLS48x8sGpmLx8OTvegj9pyHDe
         Z5saJZ/dKzFbSslwVY6QLi3SjseWCYytoW3SOEu77QjP7cgkr70QGj6r3phMK4RHbuED
         cKA6EHdAvZ8Juj1nvNwF9EsMQwwVYCRtjZVjzo8FzRL2jR21kfQBpOtdJuW5JEO/6WQJ
         5+sQ==
X-Forwarded-Encrypted: i=1; AJvYcCXouDmqY0I3ZmFg5AS2AHg9f04I9+O4XvHX3986Xgk4cAE8t3kePQRqOZ5LpziQ5GWwgATo+gw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwAWG54OhHPD07ibWSXGrL6YenmLGWdKYUuXENqAf/pY6yWb/9
	9rGsRYNJCf5onGysMIfZ/qrcF7pFjfWNxLdN1ARnI4zFHYf5FtZuqUQz/gA/iTl8VW9gZ3qkkYA
	VtySBuHINO/YpaR0Lywmsd6GL7pNl+E0=
X-Gm-Gg: ATEYQzwnonGeJHb6vDJzDRz0Ec2p6H0LEwcbbnFY+qJJSbRzJ06qE3dg0R049RSiQiM
	y0+y2up3zkOGC1F5Rsq1ImytueNrksqhWxYSV0nPP5DQuigvsxHBmzTuuzBdFnx6BjQQdSVg1IN
	VQ6vbXFN6yVfUaT6oOioQgrukIalO22oSHO22y1G+B1k215xaqA1Cp2R32qoKkddqQCOGPvsjio
	YOLa8OtJOqNMNnuMJPNUFISiKftT6VtJsp7cCtS/y51f8RryEsByI2vEIOED6rxsqeDRyhrmm94
	EygJ8MG6xPXMChac8S9Nyn4B3Ovq8/HrWm45newcGM+spYtzxX4moB682RdcQwUYdQz8P/ufJux
	/JdpjBtY/Dy96Filn22W5hXYBa1QTrwGF5SyeTdVfOt86hG8K4NQx3iSQpbyn673MVyipvKXxSm
	dTMjvpdMeAMD4yp4p58Zj09A==
X-Received: by 2002:ad4:5ca2:0:b0:899:fd80:f79f with SMTP id
 6a1803df08f44-89a81dde5abmr2633836d6.23.1773330042750; Thu, 12 Mar 2026
 08:40:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260310235642.6d9798f4@plasteblaster> <c66p7dr6vlujvnwczbnrmqx7monkdgdnm4rwewm76aibn7jza3@d3uik74dei72>
 <CANT5p=q2Lv4pSvEm5EWcM73b7NZsbt1kYEFJtjaAZRS6Gz_OjQ@mail.gmail.com> <42utcrhajix2x3feckj7ap373osq65sgfz6ximnaj4rasszret@ymhf44ddz2wh>
In-Reply-To: <42utcrhajix2x3feckj7ap373osq65sgfz6ximnaj4rasszret@ymhf44ddz2wh>
From: Steve French <smfrench@gmail.com>
Date: Thu, 12 Mar 2026 10:40:30 -0500
X-Gm-Features: AaiRm52ah7-n07dCG73FeRnFD_pUuk-pLBG0LIJHG-WBVhN-iBaM9Rrd33zCEk0
Message-ID: <CAH2r5msUyFejEbDafcWzSf5oLE3pJCdreaQTm2dxbqfmGtqCRQ@mail.gmail.com>
Subject: Re: [REGRESSION] failure to reconnect on SMB server restart with
 custom TCP port (not 445): Host is down (at least since 6.6.95)
To: Henrique Carvalho <henrique.carvalho@suse.com>
Cc: Shyam Prasad N <nspmangalore@gmail.com>, 
	"Dr. Thomas Orgis" <thomas.orgis@uni-hamburg.de>, Steve French <sfrench@samba.org>, 
	linux-cifs@vger.kernel.org, regressions@lists.linux.dev, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-224881-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,uni-hamburg.de,samba.org,vger.kernel.org,lists.linux.dev];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[smfrench@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,archlinux.org:url,suse.com:email]
X-Rspamd-Queue-Id: 27B48274BFC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Mar 12, 2026 at 10:10=E2=80=AFAM Henrique Carvalho
<henrique.carvalho@suse.com> wrote:
>
> On Thu, Mar 12, 2026 at 05:44:58AM +0530, Shyam Prasad N wrote:
> > On Wed, Mar 11, 2026 at 7:37=E2=80=AFAM Henrique Carvalho
> > <henrique.carvalho@suse.com> wrote:
> > >
> > > On Tue, Mar 10, 2026 at 11:56:42PM +0100, Dr. Thomas Orgis wrote:
> > > > Dear Linux-CIFS maintainer(s),
> > > >
> > > > I stumbled upon a regression in the Linux cifs/smb3 client when wor=
king
> > > > with a smbd using a non-standard port. I am not the first to note t=
his, see
> > > >
> > > >       https://bbs.archlinux.org/viewtopic.php?id=3D306712
> > > >
> > > > which is a report from mid last year, indicating the problem someti=
me
> > > > after Linux 6.6.72. It is a very simple issue, where details of the
> > > > kernel builds or mount setup don't seem to matter much: Older kerne=
ls
> > > > reconnect to a SMB server that was restarted (old processes killed =
and
> > > > replaced), newer kernels do not and just have a defunct mount.
> > > >
> > > > I reproduced this in our HPC cluster environment with such smb.conf=
 on
> > > > the server side
> > > >
> > > > [global]
> > > > security =3D user
> > > > map to guest =3D Bad Password
> > > > server role =3D standalone server
> > > > smb ports =3D 1445
> > > >
> > > > [public]
> > > > path =3D /some/path
> > > > guest ok =3D yes
> > > > read only =3D yes
> > > >
> > > > and such a mount command on the client:
> > > >
> > > > mount -t smb3 -o port=3D1445,user=3Dguest,password=3Dfoo //server/p=
ublic dir
> > > >
> > > > When I kill and re-start smbd on the server, older client kernels
> > > > reconnect and continue to return listings and files from the share,
> > > > while newer kernels give this:
> > > >
> > >
> > > My suspicion is that the regression was introduced by:
> > >
> > >     5713127da855 ("cifs: update dstaddr whenever channel iface is upd=
ated")
> > >
> > > That change causes parse_server_interfaces() -- should this be runnin=
g
> > > without multichannel mount option? -- to overwrite the port stored in
> > > server->dstaddr with CIFS_PORT.
> > >
> > > The attached patch preserves the existing port from server->dstaddr.
> > >
> > > Note that I have not yet tested this patch or confirmed the regressio=
n
> > > with a bisect. If you can't, I will try to do that tomorrow.
> > >
> > > --
> > > Henrique
> > > SUSE Labs
> >
> > Hi Henrique,
> >
> > AFAIK, the ignoring of port from the results was by design and part of
> > the original code back in 2018:
> > CIFS: parse and store info on iface queries
> >
> > Also, the comment in the code just above says why this is so.
> > [MS-SMB2] 2.2.32.5.1.1 Clients MUST ignore these
> >
> > I checked this section and it says:
> > Port (2 bytes): This field MUST NOT be used and MUST be reserved. The
> > server SHOULD set this field to zero, and the client MUST ignore it on
> > receipt.
> >
> > Based on the conversations here, it looks like smbd ignores this.
> >
> > I think the right fix would be to make sure that
> > cifs_chan_update_iface gets called only for secondary channels. That
> > way, it will not get called for single channel scenarios.
>
> Sure, I read the comment in the code and the MS-SMB2 protocol. The
> protocol states that "client MUST ignore [Port] on receipt". Since we
> are not using p->Port, I don't see how this is a protocol violation.

Agree. Looks harmless

> We're using the port that was selected on mount and copied over to
> server->dstaddr, so that when server->dstaddr is overwridden,
> server->dstaddr keeps the user selected port.
>
> Now, even if we only fix that for primary channels, the secondary
> channels will still get the wrong port when they are overwridden, no? So
> I don't see how that fixes the issue.
>
> Apologies if I'm missing something.
>
> Best regards,
>
> --
> Henrique
> SUSE Labs
>


--=20
Thanks,

Steve

