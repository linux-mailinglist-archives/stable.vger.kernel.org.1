Return-Path: <stable+bounces-247318-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mGbqOdOOBmoVkwIAu9opvQ
	(envelope-from <stable+bounces-247318-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 05:11:15 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id EED4F548EBE
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 05:11:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 026D130136DB
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 03:11:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFF003CBE88;
	Fri, 15 May 2026 03:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kVMH+/As"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78EE53CB918
	for <stable@vger.kernel.org>; Fri, 15 May 2026 03:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778814668; cv=pass; b=lF5/7db28PJyOW43aZpsaGU/Q+zjzModtNp+dvrVULxl715uCqxvMATZVDXwnAJacBKDMuejj2qDcHbVbeMNIcb8GlGGaNki9xWt1b81wMd8fQc5ulb9DHVLmm/BCGuUp0ApVEhA9ldOVHbuxNHvAkNmpVwEypezfUTWNf5HoaE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778814668; c=relaxed/simple;
	bh=WBzhUkFbzQTxwdmZ0DddBF/VYTlzYG0W/o96v8XXvVw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N+rtgRMU/w3dq4tTu9xQsCc6ty04NavwnbgI+jFiUOYQxQo200NMFsp5Zx996smIFCCgLc51TMVhQk7El2zfzrBUKhDt3r3na+bApW6L2sE7m7D29AXpkBCxl8JIYJ70aafxnB8IuXH+724aVLErhgJ2P+pbDIPfmMES80+0KYY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kVMH+/As; arc=pass smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-8b6dd874471so113298376d6.0
        for <stable@vger.kernel.org>; Thu, 14 May 2026 20:11:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778814666; cv=none;
        d=google.com; s=arc-20240605;
        b=K0tyZp6gm8FNfJhcSl+xWSIK17gArKt4BRHernSUcAL7LOCt7/UcWcdfge11PFMQIM
         bjLXMBSr+DmBqdmbpWXSrKUi13uYOVWvwMFajnEty4WNS+P5jN8eknYo/jV6WkWKEGN7
         mG/nk+S6eyBUp8shqR3b7WA56MiXt9SH+bjIJrinTYq2eN84Wvcgya+i5iPL9ll3wV1P
         XmJvqtlZx4yZUMDs1CFdqQsYVrHV244EA/obWG1FDp5wR/p+pzcthwKDilKPNV6Y8beU
         7sfMPT8+943A708yfVnChtG4TuCT+opbZuvAvBVfPuXEEL4Tfl2pdeEhqRaQuzRpNlbX
         rPGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=62xjzgBMlzfzuNOo9mzyAPb6sRch5lY4yZUszwPkHOc=;
        fh=KQ6qHXp/5pxLU8DeBf3L0pwKcohA4NhuXejd0yo2Fdc=;
        b=D9l/wh/N/i8RA83g+0jcauIX8DqN33Fan43pu0lm78GIRvSfq92+2UIcC09u/DVaKj
         /ac45wP+QcdBMKsQlVMGOWOlkVrHxowr0gE7ZEt9f8a1qTAkAqRJtMYafmQopdXGOtmC
         c9DqqSJqGEdpzwe/JzvWYkWORt/k1VEQLjSxjcbV0WfduMTJH6/U/TYGM2pauCQecqMU
         VfIZBLiYSVkalTCJDphH5fmpuPmq2xaO0eRyC/NllTHsrMNgy5zchXm96cJTrYEld07g
         6TZxes7MMoFb64UHCu0UmCS+awaGUY4Z31HmohSH+qvXmUoSYlZgS5bZXN2U1loObRvR
         5Zsw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778814666; x=1779419466; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=62xjzgBMlzfzuNOo9mzyAPb6sRch5lY4yZUszwPkHOc=;
        b=kVMH+/AsQBhGT2lkoJHwaYL7po9cPQyKPqAJamHr86KqauP+gdWMOUI4CZioSmjJGH
         WF+M/hFVauYvZ66zQ0sFkh3f0pHzXZyvIyswo0C6XSTKLhJV6r5WVrhUHixuidmm/sgl
         yOASzEN9jmbcDLGieyABtqUhZ+6+ksyIAtmVAjjgRVa7A04nR8NqD5CDaHEBvKHoJ+0G
         39onWagO/Y0AqE/tIwqV6U3+6jGfIafkiJzojBDYTE1xSOr3lHvCq9fEBX4iI+wf7vTi
         pma67WIAAM5SNr+QrTGO4iDyqmnJjFkc9jnEcRKpVq2AbIAQhSubHeMy1XIGCdzvcjCV
         STmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778814666; x=1779419466;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=62xjzgBMlzfzuNOo9mzyAPb6sRch5lY4yZUszwPkHOc=;
        b=RdqP/gQJBh7dXv/zbG3Q9nuL/3KhIh0Qzz8IC4XxLnjjy8dKAOwN2cDtPnaw7a5NzP
         KZ81ycYinqLBbp+10CCg9tYAzlbTSC4YbDjN0bBqygVc1KxFatymRWVCwFyAKc031gOy
         nZo3Cu5OL8lLIcTOO0aXETDV/qqA5ShMitcTWx9Zp+DR/0fUawFUa9Fu3sSqNsWnIB7X
         bzoN0MuaFtq+huStf2xU1P2BDFC4RP/XCp6rTVuXb46mhXIM+XLQR7JK0ttCOJ6bCTLS
         SwG6TPuUa9YHqLmf1G6Ke5pbNN2S90Mk575IqPfisADS6tZsPezL1sIhWxofbSJoum3+
         zkjQ==
X-Forwarded-Encrypted: i=1; AFNElJ8BC0PtITMgpztrqsC9iCLhqzrRATv4eq75CYZVswNFOrYLqzDUq0Lj8qQufEY+LQAXlVp7sF8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyj3CZx7+SB+3Yvh7HqVu5Dmf6FPwnA+9a16/OBRPIl2fABKWjV
	213yWUexVHS2SUcr4/EJU/MJMSd64vC6dhjrXdLbI9IrOdhpFE/vHR3ZbtCqCLRvo7zz4zEqhEG
	KYGqUwnjvAZW1kEoomDqILOXUZrJxhxY=
X-Gm-Gg: Acq92OHQ0q/yCImUFDknOQL/MWU9/MhqcSE1+Dq8n7qvHTjXgqMLAyvPVBydkmrKYmG
	D0sCCwLIwOXYWUJhrIEdlR/wSEozDeZSfKWLRHAx8DxhdxCI6Brzv3dPanPiUtWgUvPwAssu4Xg
	+tGDAbMXRLURcvN9OF3p5vi/GQfqsfwQc+2iTgkLqDkiio6eOXwmBFDnmpCy9XhrKtLl2Ymb3z1
	cemrv2ROZhz7h5qdvRA+8cCxn4yecDF8yKVA5ALpwrKb+1npV8R3FHalDxvLzEaDdiYJdk9rM55
	M23JNrY3jWgDTpYwKRpn8IZsyhNHSBgSH91zwXbzeVeergGp0uY2Twp4MGWZWcAF0dXLgvxGr2G
	QxL26xIjI0hSZp50WMCva29c4j1U5lRt5jzmQ1gg4pp505T6ed81isskuyanwaENx+Ab032Mldb
	dEgJCBVPIQCOwWjZk71XHP
X-Received: by 2002:a05:6214:130e:b0:8ca:17c9:c8b5 with SMTP id
 6a1803df08f44-8ca17c9cb45mr1134516d6.24.1778814666472; Thu, 14 May 2026
 20:11:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260514231825.63211-1-henrique.carvalho@suse.com> <CANT5p=r1Y3h44dE62DB+VWbGOToQv5CGBc+dR-tr14vah3SObw@mail.gmail.com>
In-Reply-To: <CANT5p=r1Y3h44dE62DB+VWbGOToQv5CGBc+dR-tr14vah3SObw@mail.gmail.com>
From: Steve French <smfrench@gmail.com>
Date: Thu, 14 May 2026 22:10:54 -0500
X-Gm-Features: AVHnY4Jm74Xa4bIG0zfrDjU9iOEiiQDh1Nj6AOK6619lzzpz8yUzY4yoRXGRRqo
Message-ID: <CAH2r5mv4jNREvwU4P_X5b6gsGVBb83sYyWtMh-FJEcW71A_WtA@mail.gmail.com>
Subject: Re: [PATCH] smb: client: protect tc_count increment in smb2_find_smb_sess_tcon_unlocked()
To: Shyam Prasad N <nspmangalore@gmail.com>
Cc: Henrique Carvalho <henrique.carvalho@suse.com>, sfrench@samba.org, pc@manguebit.org, 
	ronniesahlberg@gmail.com, sprasad@microsoft.com, tom@talpey.com, 
	bharathsm@microsoft.com, ematsumiya@suse.de, linux-cifs@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: EED4F548EBE
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-247318-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[suse.com,samba.org,manguebit.org,gmail.com,microsoft.com,talpey.com,suse.de,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[smfrench@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[11];
	FREEMAIL_FROM(0.00)[gmail.com];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Action: no action

merged into cifs-2.6.git for-next, pending more testing

On Thu, May 14, 2026 at 8:06=E2=80=AFPM Shyam Prasad N <nspmangalore@gmail.=
com> wrote:
>
> On Fri, May 15, 2026 at 4:48=E2=80=AFAM Henrique Carvalho
> <henrique.carvalho@suse.com> wrote:
> >
> > Commit 96c4af418586 ("cifs: Fix locking usage for tcon fields")
> > refactored cifs code to change cifs_tcp_ses_lock for tc_lock around
> > tc_count changes.
> >
> > There was missing lock around tc_count increment inside
> > smb2_find_smb_sess_tcon_unlocked().
> >
> > Cc: stable@vger.kernel.org
> > Fixes: 96c4af418586 ("cifs: Fix locking usage for tcon fields")
> > Signed-off-by: Henrique Carvalho <henrique.carvalho@suse.com>
> > ---
> >  fs/smb/client/smb2transport.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/fs/smb/client/smb2transport.c b/fs/smb/client/smb2transpor=
t.c
> > index e8eeff9e50d6..1143ee52470a 100644
> > --- a/fs/smb/client/smb2transport.c
> > +++ b/fs/smb/client/smb2transport.c
> > @@ -169,7 +169,9 @@ smb2_find_smb_sess_tcon_unlocked(struct cifs_ses *s=
es, __u32  tid)
> >         list_for_each_entry(tcon, &ses->tcon_list, tcon_list) {
> >                 if (tcon->tid !=3D tid)
> >                         continue;
> > +               spin_lock(&tcon->tc_lock);
> >                 ++tcon->tc_count;
> > +               spin_unlock(&tcon->tc_lock);
> >                 trace_smb3_tcon_ref(tcon->debug_id, tcon->tc_count,
> >                                     netfs_trace_tcon_ref_get_find_sess_=
tcon);
> >                 return tcon;
> > --
> > 2.54.0
> >
> >
> Reviewed-by: Shyam Prasad N <sprasad@microsoft.com>
>
> --
> Regards,
> Shyam
>


--=20
Thanks,

Steve

