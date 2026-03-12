Return-Path: <stable+bounces-224876-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eOC/CnzXsmlDQAAAu9opvQ
	(envelope-from <stable+bounces-224876-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 16:10:52 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 96719273F7E
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 16:10:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D612F306EE32
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 15:03:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AD9B38B142;
	Thu, 12 Mar 2026 15:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ZbmXXtkx"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 774C439936F
	for <stable@vger.kernel.org>; Thu, 12 Mar 2026 15:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773327793; cv=none; b=PNn+gzc1EZL5z8LFRClEUU8VUy1ykUMzKcm0mIbBisYQ20cLSclpkncvPsdcXOK0oPiLZrIXJqCyGiLAN3IdPU8gbFJOKDHEXE18OvgbyzdsX9XH4t+EJeAr8cQdomInlwh5PBAMn7tUlhKkSejitgV6r7znpTRBp/V+pgrkvMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773327793; c=relaxed/simple;
	bh=gLc30Z+9vOBzkAprgy+ZzWzCvuoZOmSPjY+GSFBC7K4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SsADpAcR50lQL6ESSak918Dw+TsnwKJO+4Xjyclr1gvzyDQYqB2PqSA8Wu7Acwn2xBGXXOzNFbQuPdy56YEGYxwwYBfRmjQAIcmsSgZLQG8hz9fZIyrsuSckVrOw8QC4fUNTS57Y/iP/uxvWefzu7s1kWrgAbrP4AsCKtmdJJes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=ZbmXXtkx; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-38a870c777dso1354871fa.2
        for <stable@vger.kernel.org>; Thu, 12 Mar 2026 08:03:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1773327789; x=1773932589; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=w3Z0IgmvA6IrttCl9VcQbxLY4PbNB0saZqQGQHabijM=;
        b=ZbmXXtkx0zu/uKz4QxZUYM5VmcUOiuiqm1bHbP2YDmIJQprq+AUc/BeQb3s4o9HFQ8
         JG9h5dtNj0DmKHymAtPLr0LTbTJszdwCfoJnhUES84CI2581A7n/EWGIA4xaPu3KKapx
         2IX39i37J1O7Xz3PdWiQWBgF38yqJt6T9iPU/Z6rPi1rzyh/cb1kH1D82qxao1gHAFtD
         dWNgjPyEKCMfw+rz5acVIR/nuHF3nplmA2O+BchMnaoLu3fRnDHux4FIokHrlmK1Ccam
         EiVr2LHgLXuwEoCHeL4Re5nqkKT8THRJvrr9TybSOHSiepIZqz61/4ij8HznG17eHiv4
         4ntw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773327789; x=1773932589;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=w3Z0IgmvA6IrttCl9VcQbxLY4PbNB0saZqQGQHabijM=;
        b=FrBrnsOz2HZnz4JUIBIjuOKVA//LupFGs3Jr8MrbYv8rC3wVOGCddaJNjxyqvC0Ae6
         8NEgJvEGOWw5sfvLsU3mJaCKGE+c1akxUPzyVBmYQcnV6hFmDrHdT5L08grV0eReGMHH
         ZOklz1STt81cYKnc6YHBlAMdO3CmwrlLBaigUDbqD4xA1lRKhzqQIi1askCMgIcftwv0
         HSbXiyFmH1dv3JF9Sp+a83gGARoGhE1hPiUwWhN3hHqxxjhO0ez/COEBd3CHjBz+uSOD
         Jj6oCQ76YCeZDxsm5fIXlQAZar35PpI+khJmHLfRJUdXt3G5ztyeMHCzP5zaXK6/f2vN
         kOHQ==
X-Forwarded-Encrypted: i=1; AJvYcCVk5jy1R78OZt6jsgrhsIM5YqgCJ0svL60C7uNQ3eaTjFeB7jHSe2rUcQ0gdgpXIGUvrhsMuuI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmZ4B2ylcnLErMs9nOkiIS09w3u+S8Y8UwlFoZxNukSzlptoQQ
	IlLVLA48wqfHUdrhezhe2bzJeCsJ3B8GCeh9kX7x277/W9zGtxFj9LpsOYptniVOlO4=
X-Gm-Gg: ATEYQzz6hywRdWSawz53CiBEVdynySxGEqGqKuBv9BnlljroJGwm/fFLz6hIuyht78v
	zmcblQfBPXLk6gsKrEIXD0+/vVMRp9Y9RCyYK4xhSmW+64srj+ZIKHztcN1pbhxnlG6deGydFQi
	XRh73u74t3jj9sfDD3OYnn2I+H5UEyx6CcNJEDf/dMGrE2DZxDy9TrOQX02tIci+tXmCfk38Ur3
	GsjsRTxg41apUC4pWkooQ2w6jM8qyW8Oew1oEM9H5mHJF2f3u2z2OcjJX5JLVlfWOJKB75TRRsA
	9YVi84ii7apkZevNvTvC11Qz+Udgx+tXebw2WlWtXik7dv6n6XIYWyNo0CMq9XfgxqvU/WrX0z/
	4omg3SBoqTqRH/bNdOspKywoeEXh0l7vUhDJab++NxqaIfoO+8BWTvmSGxUDDbxp6zRp7XpsWGd
	PNXPncUAxZFRZBhpz/5GIXagNYKtBZav61YsYQq0N0cSpBO10vA/mGVZc=
X-Received: by 2002:a05:651c:2102:b0:38a:45f8:6270 with SMTP id 38308e7fff4ca-38a67e1aa9cmr23403431fa.21.1773327787720;
        Thu, 12 Mar 2026 08:03:07 -0700 (PDT)
Received: from precision.tail0b5424.ts.net ([2804:7f0:6402:b103:6a0a:3e1c:778a:5cc7])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2be8aa7492dsm6507324eec.29.2026.03.12.08.03.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 08:03:06 -0700 (PDT)
Date: Thu, 12 Mar 2026 12:03:01 -0300
From: Henrique Carvalho <henrique.carvalho@suse.com>
To: Shyam Prasad N <nspmangalore@gmail.com>
Cc: "Dr. Thomas Orgis" <thomas.orgis@uni-hamburg.de>, 
	Steve French <sfrench@samba.org>, linux-cifs@vger.kernel.org, regressions@lists.linux.dev, 
	stable@vger.kernel.org
Subject: Re: [REGRESSION] failure to reconnect on SMB server restart with
 custom TCP port (not 445): Host is down (at least since 6.6.95)
Message-ID: <42utcrhajix2x3feckj7ap373osq65sgfz6ximnaj4rasszret@ymhf44ddz2wh>
References: <20260310235642.6d9798f4@plasteblaster>
 <c66p7dr6vlujvnwczbnrmqx7monkdgdnm4rwewm76aibn7jza3@d3uik74dei72>
 <CANT5p=q2Lv4pSvEm5EWcM73b7NZsbt1kYEFJtjaAZRS6Gz_OjQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANT5p=q2Lv4pSvEm5EWcM73b7NZsbt1kYEFJtjaAZRS6Gz_OjQ@mail.gmail.com>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-224876-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[suse.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[henrique.carvalho@suse.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6]
X-Rspamd-Queue-Id: 96719273F7E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Mar 12, 2026 at 05:44:58AM +0530, Shyam Prasad N wrote:
> On Wed, Mar 11, 2026 at 7:37 AM Henrique Carvalho
> <henrique.carvalho@suse.com> wrote:
> >
> > On Tue, Mar 10, 2026 at 11:56:42PM +0100, Dr. Thomas Orgis wrote:
> > > Dear Linux-CIFS maintainer(s),
> > >
> > > I stumbled upon a regression in the Linux cifs/smb3 client when working
> > > with a smbd using a non-standard port. I am not the first to note this, see
> > >
> > >       https://bbs.archlinux.org/viewtopic.php?id=306712
> > >
> > > which is a report from mid last year, indicating the problem sometime
> > > after Linux 6.6.72. It is a very simple issue, where details of the
> > > kernel builds or mount setup don't seem to matter much: Older kernels
> > > reconnect to a SMB server that was restarted (old processes killed and
> > > replaced), newer kernels do not and just have a defunct mount.
> > >
> > > I reproduced this in our HPC cluster environment with such smb.conf on
> > > the server side
> > >
> > > [global]
> > > security = user
> > > map to guest = Bad Password
> > > server role = standalone server
> > > smb ports = 1445
> > >
> > > [public]
> > > path = /some/path
> > > guest ok = yes
> > > read only = yes
> > >
> > > and such a mount command on the client:
> > >
> > > mount -t smb3 -o port=1445,user=guest,password=foo //server/public dir
> > >
> > > When I kill and re-start smbd on the server, older client kernels
> > > reconnect and continue to return listings and files from the share,
> > > while newer kernels give this:
> > >
> >
> > My suspicion is that the regression was introduced by:
> >
> >     5713127da855 ("cifs: update dstaddr whenever channel iface is updated")
> >
> > That change causes parse_server_interfaces() -- should this be running
> > without multichannel mount option? -- to overwrite the port stored in
> > server->dstaddr with CIFS_PORT.
> >
> > The attached patch preserves the existing port from server->dstaddr.
> >
> > Note that I have not yet tested this patch or confirmed the regression
> > with a bisect. If you can't, I will try to do that tomorrow.
> >
> > --
> > Henrique
> > SUSE Labs
> 
> Hi Henrique,
> 
> AFAIK, the ignoring of port from the results was by design and part of
> the original code back in 2018:
> CIFS: parse and store info on iface queries
> 
> Also, the comment in the code just above says why this is so.
> [MS-SMB2] 2.2.32.5.1.1 Clients MUST ignore these
> 
> I checked this section and it says:
> Port (2 bytes): This field MUST NOT be used and MUST be reserved. The
> server SHOULD set this field to zero, and the client MUST ignore it on
> receipt.
> 
> Based on the conversations here, it looks like smbd ignores this.
> 
> I think the right fix would be to make sure that
> cifs_chan_update_iface gets called only for secondary channels. That
> way, it will not get called for single channel scenarios.

Sure, I read the comment in the code and the MS-SMB2 protocol. The
protocol states that "client MUST ignore [Port] on receipt". Since we
are not using p->Port, I don'se see how this is a protocol violation.

We're using the port that was selected on mount and copied over to
server->dstaddr, so that when server->dstaddr is overwridden,
server->dstaddr keeps the user selected port.

Now, even if we only fix that for primary channels, the secondary
channels will still get the wrong port when they are overwridden, no? So
I don't see how that fixes the issue.

Apologies if I'm missing something.

Best regards,

-- 
Henrique
SUSE Labs

