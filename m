Return-Path: <stable+bounces-224774-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4KLqN5MFsmnXHwAAu9opvQ
	(envelope-from <stable+bounces-224774-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 01:15:15 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A41326B8D4
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 01:15:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 13222302A1B6
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 00:15:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FD5A309F1B;
	Thu, 12 Mar 2026 00:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d0N+x/xI"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B363C3090C4
	for <stable@vger.kernel.org>; Thu, 12 Mar 2026 00:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773274513; cv=pass; b=YR9/GYtfTrET9u8jncFzjs7hps3Eof3Cfxp30AK6BElr9/u0opH3Z0x9dkENIDekVCbICV/l6eeRsNrU5zPpeSxCBQJa2sxabauckdoxmfBY5urEDsG305TcuzngkyuwgSNdHB4zptH/GIiyR3Y//4pNXfL8Fjt5ExUXsxe3pW8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773274513; c=relaxed/simple;
	bh=6/itMLCFfyLvJoeA9cy22RHpmFM4fQuJ59IcW2RTNl4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ahTMsEeQJ6xhtZZPqAhNn54y7ybI4F2I8OPgDj4KtpJg6+O8CyiPVX7PVbKW2ErasBIxtm37WbQlHcxI2bcay0zzrakXvwybWklz+EJgRD7WS76BWe6YIYje1QxG0Rv7+8x2QOypNukpj7vRD0b7GU+HwxFcEW1BEq0r3SkeHfw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d0N+x/xI; arc=pass smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-65c0891f4e9so570566a12.1
        for <stable@vger.kernel.org>; Wed, 11 Mar 2026 17:15:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773274510; cv=none;
        d=google.com; s=arc-20240605;
        b=FpfBtBNYwFZVM3aAPUoNQ77DsxFF8kVWicyKnbLJcm3a7I47AYvdvJXgBwVbN+YD4w
         RsZhjYYpygzzXdqlCt57xpmmTvG+GAa3DHB/60PzQUX8SMhYhHPPMcIHCX8A/hMfzskZ
         E5l5xRUxXY6ShCNVKIhShtN90fSRrMYf/IFjpvdSUXk/FN+7lR6PO2RFhE0wLvYopQ15
         mZyU+23b5xvXZha/nDHBTote5R+tjPWnn7FX4wUTv9Un0U0C4Bt0jQoyXGTIab6pSEQ4
         sW2ghdDETwtuT+Hqf8n8oQdd64VVNuTr859wLFY+X9yFsbL6k+MEosyUhtamn4F17WAe
         9CdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=pbDxkeMXFgFuSfzV6w0UsHl8/LPcKe8YhwEDSHSsljs=;
        fh=e6Xn4NO97Xw7/hFmPRNNiAW1gXd9efH9sIFg2xGB7+s=;
        b=i8QdC2WVXy1z8x3AoVBQOB05Gm4+R24foe4GbyXNyq77GWtbwylB5rvYp35+eKCYAg
         M+6BAa4oTTu3h0nm7N4KWgTUReS39fMnvk7nz9ptBQkZjx5FgNAG/b5VEuRZxuZYRKQy
         C5nyRKB7k9w4QSNwR5Pi0Ybj7eEgi1PzASDqyeBLAf6jMG/iloKO0CATB5+2tP60fvOP
         0MPQtXwu3UwTmgKIQIoSNOzpe5S7YuaZco1gjAki0FIFucbEOpm+1lt//pDnLSBJ6LAk
         +3xji3dFqgow7FO98MMXWEMSRY5znxLX+Mb0uz066F3R+jlnokbl5hTCm/m5Ob6XGWFV
         6noA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773274510; x=1773879310; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pbDxkeMXFgFuSfzV6w0UsHl8/LPcKe8YhwEDSHSsljs=;
        b=d0N+x/xI7jNXbvlXlndVml3xlssmPKFdOwIFUKKX8tra0DYDy62dh9oYazJVFlKx2i
         tLn1bHuf6IDvnhGaXUglVzlf04eqvRJeRSAiTtBPBDRLDnA7dgRTPlDHO/vaY0kkcXr4
         2qtuS5pTRjLoQYf0mF27Nqk2doAB57nrsd/x5eF/Kvib1j5m0lcq8EVi1g4nb+yKINJa
         EuiVDAU/8I+kUK+lx6Jka1QD0thYSfJmsPw+WELj5Bt2MwgYXteXUCxYhUWD4Vi9vox0
         +q4df3Vl0qlV2kC/7pEdX0VimR3Uqdp3w/9anJgrS3fMkqUCdaGXaPX8tl+cYcwM6iNs
         HVyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773274510; x=1773879310;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pbDxkeMXFgFuSfzV6w0UsHl8/LPcKe8YhwEDSHSsljs=;
        b=M/2ZpwvIsBWQClsVh6IxyuH4GO1MizhxwKRlpdhRZv/r9n/HlqaGmyg3a0wZr/22zK
         Mw3KErwBDLnurX6nBz5cEaS1oh/J6BKtPnB72VGQt2vL7Rmj3WCgqhQc6BqSHzUifyP4
         xhTLOUKzLs0Sk48/7fV/Z3tULCSabiDz3l2FnUygejzJ5XtAhiFQZMxX+wWGZVEG7+mk
         MsHxyzfPKIUn7FDmz7waVWv4yb+mXNDAAtcxcOZvI1z8B2y4gUS9dxpVphFP/fpFBSGK
         PoLEGq0VkRutyZXNKKJRNyg2l1xw04PL5fpEVAU5uN8NBYObLM/7LfmTfbmun/zO9WW+
         hFgw==
X-Forwarded-Encrypted: i=1; AJvYcCVsjVhLxCmOmRApOku3UJN1J7kNuwqksIy9xiM0tZOmnkUzoJmYMRVD3slEwXqXjf0aANg0tw8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyy9KiCaszergyuzvsWnHEbyCvkLMr+vFssF5osxPJ8oeN8IU2T
	TV4k+i68dpvMcsfsliABtWN4ZeIf7rZlz2uPhu9mEeeeQdgYpcRbi1+mJnmGEKZUdMvCTA/a17X
	qwsx8vGfxWQyOdG/7AtVFnfin6GddOSQ=
X-Gm-Gg: ATEYQzzdYYTJC8o+nIDNhgOftix7WQr5mOvcaI4d9+hieS4GBZd0yUSxjwVzxvsacvi
	gjnEFPiqwclzfeSBrvTRsgPFtE3gZ9Aw7lQ8e1lGBDjYFLztQaLYurR6xjNBdwbYEVGo5Zz5CrI
	qjBAshYEZQ2gzhkUNxfbfqt4/8MnCXEdMyJBrRz2GNXEk/92vD3nxPVvTfcvRCQRATwubIzOxZ9
	wd+QGhlerNNkgOgV6C8HR37V2mjY/CR5kFvZ2Y/m+PCARzU0dkk6zEt6XwlGVUkNweoXBWq07cD
	ueJOfbTR6NzMuWwb
X-Received: by 2002:a05:6402:5109:b0:660:f98d:227f with SMTP id
 4fb4d7f45d1cf-66319ee21aemr2290781a12.28.1773274509925; Wed, 11 Mar 2026
 17:15:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260310235642.6d9798f4@plasteblaster> <c66p7dr6vlujvnwczbnrmqx7monkdgdnm4rwewm76aibn7jza3@d3uik74dei72>
In-Reply-To: <c66p7dr6vlujvnwczbnrmqx7monkdgdnm4rwewm76aibn7jza3@d3uik74dei72>
From: Shyam Prasad N <nspmangalore@gmail.com>
Date: Thu, 12 Mar 2026 05:44:58 +0530
X-Gm-Features: AaiRm50oWdiNjT1ebRKWHilt31EW_fjU4bk5ELRtpIJIFmb-N6WXXm4YQx0WL0s
Message-ID: <CANT5p=q2Lv4pSvEm5EWcM73b7NZsbt1kYEFJtjaAZRS6Gz_OjQ@mail.gmail.com>
Subject: Re: [REGRESSION] failure to reconnect on SMB server restart with
 custom TCP port (not 445): Host is down (at least since 6.6.95)
To: Henrique Carvalho <henrique.carvalho@suse.com>
Cc: "Dr. Thomas Orgis" <thomas.orgis@uni-hamburg.de>, Steve French <sfrench@samba.org>, 
	linux-cifs@vger.kernel.org, regressions@lists.linux.dev, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-224774-lists,stable=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nspmangalore@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,archlinux.org:url]
X-Rspamd-Queue-Id: 5A41326B8D4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Mar 11, 2026 at 7:37=E2=80=AFAM Henrique Carvalho
<henrique.carvalho@suse.com> wrote:
>
> On Tue, Mar 10, 2026 at 11:56:42PM +0100, Dr. Thomas Orgis wrote:
> > Dear Linux-CIFS maintainer(s),
> >
> > I stumbled upon a regression in the Linux cifs/smb3 client when working
> > with a smbd using a non-standard port. I am not the first to note this,=
 see
> >
> >       https://bbs.archlinux.org/viewtopic.php?id=3D306712
> >
> > which is a report from mid last year, indicating the problem sometime
> > after Linux 6.6.72. It is a very simple issue, where details of the
> > kernel builds or mount setup don't seem to matter much: Older kernels
> > reconnect to a SMB server that was restarted (old processes killed and
> > replaced), newer kernels do not and just have a defunct mount.
> >
> > I reproduced this in our HPC cluster environment with such smb.conf on
> > the server side
> >
> > [global]
> > security =3D user
> > map to guest =3D Bad Password
> > server role =3D standalone server
> > smb ports =3D 1445
> >
> > [public]
> > path =3D /some/path
> > guest ok =3D yes
> > read only =3D yes
> >
> > and such a mount command on the client:
> >
> > mount -t smb3 -o port=3D1445,user=3Dguest,password=3Dfoo //server/publi=
c dir
> >
> > When I kill and re-start smbd on the server, older client kernels
> > reconnect and continue to return listings and files from the share,
> > while newer kernels give this:
> >
>
> My suspicion is that the regression was introduced by:
>
>     5713127da855 ("cifs: update dstaddr whenever channel iface is updated=
")
>
> That change causes parse_server_interfaces() -- should this be running
> without multichannel mount option? -- to overwrite the port stored in
> server->dstaddr with CIFS_PORT.
>
> The attached patch preserves the existing port from server->dstaddr.
>
> Note that I have not yet tested this patch or confirmed the regression
> with a bisect. If you can't, I will try to do that tomorrow.
>
> --
> Henrique
> SUSE Labs

Hi Henrique,

AFAIK, the ignoring of port from the results was by design and part of
the original code back in 2018:
CIFS: parse and store info on iface queries

Also, the comment in the code just above says why this is so.
[MS-SMB2] 2.2.32.5.1.1 Clients MUST ignore these

I checked this section and it says:
Port (2 bytes): This field MUST NOT be used and MUST be reserved. The
server SHOULD set this field to zero, and the client MUST ignore it on
receipt.

Based on the conversations here, it looks like smbd ignores this.

I think the right fix would be to make sure that
cifs_chan_update_iface gets called only for secondary channels. That
way, it will not get called for single channel scenarios.

--=20
Regards,
Shyam

