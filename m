Return-Path: <stable+bounces-23855-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DD7C868B75
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 09:59:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7FAD281FEB
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 08:59:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 828B47BAE7;
	Tue, 27 Feb 2024 08:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="EnOsMCd0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pRW/syV0"
X-Original-To: stable@vger.kernel.org
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 234FB54BCF
	for <stable@vger.kernel.org>; Tue, 27 Feb 2024 08:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.26
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709024336; cv=none; b=D1P1W7c8tag5XN4JkhuTTZLLQLfivZhJ6m9kW2be6b77lmxzlJaaOfRLdr2JLIb72Lad0IEJQ5c1DlhlWK9x10mmja+kaU/7zTOe+hqEmLrqXaGx5RLKruyfDOb/8T5Heb1ZLn4I84MN1Loc3xO6c+WzNbEz7e+H6sN4y3CsHkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709024336; c=relaxed/simple;
	bh=5zaIKVQhj0vPnRjCZNVxkW7Q5rK3iM/OIFc1+bfq4yY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a5XfCXoetC1ozCpAQsw+CVSO8xZESqbGvPh6n/VQ0bXaWErOvJN8Ps+lBbj1kXgG77cF7Fe1or2POTL1qyKV0sqgGKZNOG+UBhRuB5RWvsV728FUUK1CwkghKs/8aDbWaspPTotCMFmZVA5mG5NIrAlCtEfMB1CWRMfBBQKeGXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=EnOsMCd0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=pRW/syV0; arc=none smtp.client-ip=66.111.4.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailout.nyi.internal (Postfix) with ESMTP id E9EB05C00E0;
	Tue, 27 Feb 2024 03:58:52 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Tue, 27 Feb 2024 03:58:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1709024332;
	 x=1709110732; bh=uuyUE0dPb0hn3v86Fosn1VSBdsAyIFY8EbiPDJc1M60=; b=
	EnOsMCd0RLWHqK+GxUEIQD5N2g9NwCoyNxPVknKZsAyRwGEYo/XLej4LX2c0YiCU
	Lwlm4QRt8o4d/b3/ev2YRNiE12iFJfglfIV+QTVJzoH4I3RNRc252R4MfAZGXpM0
	fSEXuGDWSUQEz5AJbkL4XS38JJMUQg9UT58auNsk5GjOR1ay7J9NAc6MYBv43f1g
	dD1RJL7XJQ2a1z02y1Scp4usnp3PqYWYyReJkhCyJq0oRJIYELUDEtatiiGk+3uW
	92k+rrmvft45aDU+40n06/dI84N9ArITtCcHEL8mrD1bz8MQcE/OcwxhGwNM5Sry
	mrpTNUw7hb5xkz/EdnjNZw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1709024332; x=
	1709110732; bh=uuyUE0dPb0hn3v86Fosn1VSBdsAyIFY8EbiPDJc1M60=; b=p
	RW/syV0JDT7jYVQ4Chmq0KwHkpSsZWjmKIvvkMZJ8zTcNQF0bCKNOCIqI35lFIR/
	IaYE7BVaMS6N6s3A7Jr2T6AIIiTSxi1rwsnkQjrPTsWnbg8naQO1lb8Ae2tbnZdX
	aPS04ygtaHJttY8ETpGtFbcI7pkdSlKXMbVrcOH7fNeSptEkcvJ+BXG1Tmm5Gn4H
	2Bq8kaXdVkmfviyM7LdBbzCvtUi4/bPQzy7UJbe2z9l/Sr1naFhhKQfM88o3MwFY
	tBmZuYWuNnSvh6r6XZRHDDWxH3uoZpwzjhdSW5aCrgdzBMtHeqKUB2EpxqIaqDVP
	5A16zpsRglKP+yE0uwzZg==
X-ME-Sender: <xms:TKTdZaopXZKnKpJ3280_O4Ga94hzrmGUNqy7HtHi62hBqRgw7dYD1Q>
    <xme:TKTdZYqVxyG6m4-KwnvGrZrRDhAvhn9PxgNSpMUyDigwlfi6OGRCypKGTLXW9gxiF
    RClnHrPoWz-aQ>
X-ME-Received: <xmr:TKTdZfP_7DCiZJ8Sx29IXibIRI6nq_eJjYQ4pK4tXETvtnWkK3N5gTkaE9pdH7fAErxkSvS-3SVfsLLJuuVhkY_Jp8i_qVHRsg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrgeefgdduvdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdejnecuhfhrohhmpefirhgv
    ghcumffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtffrrghtthgvrhhnpeelke
    ehjeejieehjedvteehjeevkedugeeuiefgfedufefgfffhfeetueeikedufeenucffohhm
    rghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhrvghgsehkrhhorghhrdgtohhm
X-ME-Proxy: <xmx:TKTdZZ64xLWgRbmmuFlyigBSYRNCRAKtWAzxit-PNJfFJBWQW3aTyw>
    <xmx:TKTdZZ5TjJSuEal663m2sp7-GCS1XYrdFQ6QPFxtlATFbNoei-sqUg>
    <xmx:TKTdZZgqbu0pog9XNlNEMQL-5PE8h4TWoLQU1NS9fN75-X8A_mfVbw>
    <xmx:TKTdZQrlTf8mKPXVXaAI0XO6Ba7Ka9XBxe8YCOK-6kKrWJAjBf-3mw>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 27 Feb 2024 03:58:52 -0500 (EST)
Date: Tue, 27 Feb 2024 09:58:51 +0100
From: Greg KH <greg@kroah.com>
To: Shyam Prasad N <nspmangalore@gmail.com>
Cc: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
	smfrench@gmail.com, stable@vger.kernel.org, sprasad@microsoft.com,
	stfrench@microsoft.com, darren.kenny@oracle.com, dai.ngo@oracle.com
Subject: Re: [PATCH 5.15.y] cifs: fix mid leak during reconnection after
 timeout threshold
Message-ID: <2024022745-amount-arousal-3f82@gregkh>
References: <20240226103025.736067-1-harshit.m.mogalapalli@oracle.com>
 <CANT5p=qNgSXsBg8Str6Er3noBdMwsB2gH5EMB+NbX59O=r_nNg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANT5p=qNgSXsBg8Str6Er3noBdMwsB2gH5EMB+NbX59O=r_nNg@mail.gmail.com>

On Mon, Feb 26, 2024 at 04:31:16PM +0530, Shyam Prasad N wrote:
> On Mon, Feb 26, 2024 at 4:00 PM Harshit Mogalapalli
> <harshit.m.mogalapalli@oracle.com> wrote:
> >
> > From: Shyam Prasad N <nspmangalore@gmail.com>
> >
> > commit 69cba9d3c1284e0838ae408830a02c4a063104bc upstream.
> >
> > When the number of responses with status of STATUS_IO_TIMEOUT
> > exceeds a specified threshold (NUM_STATUS_IO_TIMEOUT), we reconnect
> > the connection. But we do not return the mid, or the credits
> > returned for the mid, or reduce the number of in-flight requests.
> >
> > This bug could result in the server->in_flight count to go bad,
> > and also cause a leak in the mids.
> >
> > This change moves the check to a few lines below where the
> > response is decrypted, even of the response is read from the
> > transform header. This way, the code for returning the mids
> > can be reused.
> >
> > Also, the cifs_reconnect was reconnecting just the transport
> > connection before. In case of multi-channel, this may not be
> > what we want to do after several timeouts. Changed that to
> > reconnect the session and the tree too.
> >
> > Also renamed NUM_STATUS_IO_TIMEOUT to a more appropriate name
> > MAX_STATUS_IO_TIMEOUT.
> >
> > Fixes: 8e670f77c4a5 ("Handle STATUS_IO_TIMEOUT gracefully")
> > Signed-off-by: Shyam Prasad N <sprasad@microsoft.com>
> > Signed-off-by: Steve French <stfrench@microsoft.com>
> > [Harshit: Backport to 5.15.y]
> >  Conflicts:
> >         fs/cifs/connect.c -- 5.15.y doesn't have commit 183eea2ee5ba
> >         ("cifs: reconnect only the connection and not smb session where
> >  possible") -- User cifs_reconnect(server) instead of
> > cifs_reconnect(server, true)
> >
> > Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
> > ---
> > Would be nice to get a review from author/maintainer of the upstream patch.
> >
> > A backport request was made previously but the patch didnot apply
> > cleanly then:
> > https://lore.kernel.org/all/CANT5p=oPGnCd4H5ppMbAiHsAKMor3LT_aQRqU7tKu=q6q1BGQg@mail.gmail.com/
> >
> > xfstests with cifs done: before and after patching with this patch on 5.15.149.
> > There is no change in test results before and after the patch.
> >
> > Ran: cifs/001 generic/001 generic/002 generic/005 generic/006 generic/007
> > generic/010 generic/011 generic/013 generic/014 generic/023 generic/024
> > generic/028 generic/029 generic/030 generic/036 generic/069 generic/074
> > generic/075 generic/084 generic/091 generic/095 generic/098 generic/100
> > generic/109 generic/112 generic/113 generic/124 generic/127 generic/129
> > generic/130 generic/132 generic/133 generic/135 generic/141 generic/169
> > generic/198 generic/207 generic/208 generic/210 generic/211 generic/212
> > generic/221 generic/239 generic/241 generic/245 generic/246 generic/247
> > generic/248 generic/249 generic/257 generic/263 generic/285 generic/286
> > generic/308 generic/309 generic/310 generic/315 generic/323 generic/339
> > generic/340 generic/344 generic/345 generic/346 generic/354 generic/360
> > generic/393 generic/394
> > Not run: generic/010 generic/286 generic/315
> > Failures: generic/075 generic/112 generic/127 generic/285
> > Failed 4 of 68 tests
> >
> > SECTION       -- smb3
> > =========================
> > Ran: cifs/001 generic/001 generic/002 generic/005 generic/006 generic/007
> > generic/010 generic/011 generic/013 generic/014 generic/023 generic/024
> > generic/028 generic/029 generic/030 generic/036 generic/069 generic/074
> > generic/075 generic/084 generic/091 generic/095 generic/098 generic/100
> > generic/109 generic/112 generic/113 generic/124 generic/127 generic/129
> > generic/130 generic/132 generic/133 generic/135 generic/141 generic/169
> > generic/198 generic/207 generic/208 generic/210 generic/211 generic/212
> > generic/221 generic/239 generic/241 generic/245 generic/246 generic/247
> > generic/248 generic/249 generic/257 generic/263 generic/285 generic/286
> > generic/308 generic/309 generic/310 generic/315 generic/323 generic/339
> > generic/340 generic/344 generic/345 generic/346 generic/354 generic/360
> > generic/393 generic/394
> > Not run: generic/010 generic/014 generic/129 generic/130 generic/239
> > Failures: generic/075 generic/091 generic/112 generic/127 generic/263 generic/285 generic/286
> > Failed 7 of 68 tests
> >
> > SECTION       -- smb21
> > =========================
> > Ran: cifs/001 generic/001 generic/002 generic/005 generic/006 generic/007
> > generic/010 generic/011 generic/013 generic/014 generic/023 generic/024
> > generic/028 generic/029 generic/030 generic/036 generic/069 generic/074
> > generic/075 generic/084 generic/091 generic/095 generic/098 generic/100
> > generic/109 generic/112 generic/113 generic/124 generic/127 generic/129
> > generic/130 generic/132 generic/133 generic/135 generic/141 generic/169
> > generic/198 generic/207 generic/208 generic/210 generic/211 generic/212
> > generic/221 generic/239 generic/241 generic/245 generic/246 generic/247
> > generic/248 generic/249 generic/257 generic/263 generic/285 generic/286
> > generic/308 generic/309 generic/310 generic/315 generic/323 generic/339
> > generic/340 generic/344 generic/345 generic/346 generic/354 generic/360
> > generic/393 generic/394
> > Not run: generic/010 generic/014 generic/129 generic/130 generic/239 generic/286 generic/315
> > Failures: generic/075 generic/112 generic/127 generic/285
> > Failed 4 of 68 tests
> >
> > SECTION       -- smb2
> > =========================
> > Ran: cifs/001 generic/001 generic/002 generic/005 generic/006 generic/007
> > generic/010 generic/011 generic/013 generic/014 generic/023 generic/024
> > generic/028 generic/029 generic/030 generic/036 generic/069 generic/074
> > generic/075 generic/084 generic/091 generic/095 generic/098 generic/100
> > generic/109 generic/112 generic/113 generic/124 generic/127 generic/129
> > generic/130 generic/132 generic/133 generic/135 generic/141 generic/169
> > generic/198 generic/207 generic/208 generic/210 generic/211 generic/212
> > generic/221 generic/239 generic/241 generic/245 generic/246 generic/247
> > generic/248 generic/249 generic/257 generic/263 generic/285 generic/286
> > generic/308 generic/309 generic/310 generic/315 generic/323 generic/339
> > generic/340 generic/344 generic/345 generic/346 generic/354 generic/360
> > generic/393 generic/394
> > Not run: generic/010 generic/286 generic/315
> > Failures: generic/075 generic/112 generic/127 generic/285
> > Failed 4 of 68 tests
> > ---
> >  fs/cifs/connect.c | 19 +++++++++++++++----
> >  1 file changed, 15 insertions(+), 4 deletions(-)
> >
> > diff --git a/fs/cifs/connect.c b/fs/cifs/connect.c
> > index a521c705b0d7..a3e4811b7871 100644
> > --- a/fs/cifs/connect.c
> > +++ b/fs/cifs/connect.c
> > @@ -59,7 +59,7 @@ extern bool disable_legacy_dialects;
> >  #define TLINK_IDLE_EXPIRE      (600 * HZ)
> >
> >  /* Drop the connection to not overload the server */
> > -#define NUM_STATUS_IO_TIMEOUT   5
> > +#define MAX_STATUS_IO_TIMEOUT   5
> >
> >  struct mount_ctx {
> >         struct cifs_sb_info *cifs_sb;
> > @@ -965,6 +965,7 @@ cifs_demultiplex_thread(void *p)
> >         struct mid_q_entry *mids[MAX_COMPOUND];
> >         char *bufs[MAX_COMPOUND];
> >         unsigned int noreclaim_flag, num_io_timeout = 0;
> > +       bool pending_reconnect = false;
> >
> >         noreclaim_flag = memalloc_noreclaim_save();
> >         cifs_dbg(FYI, "Demultiplex PID: %d\n", task_pid_nr(current));
> > @@ -1004,6 +1005,8 @@ cifs_demultiplex_thread(void *p)
> >                 cifs_dbg(FYI, "RFC1002 header 0x%x\n", pdu_length);
> >                 if (!is_smb_response(server, buf[0]))
> >                         continue;
> > +
> > +               pending_reconnect = false;
> >  next_pdu:
> >                 server->pdu_size = pdu_length;
> >
> > @@ -1063,10 +1066,13 @@ cifs_demultiplex_thread(void *p)
> >                 if (server->ops->is_status_io_timeout &&
> >                     server->ops->is_status_io_timeout(buf)) {
> >                         num_io_timeout++;
> > -                       if (num_io_timeout > NUM_STATUS_IO_TIMEOUT) {
> > -                               cifs_reconnect(server);
> > +                       if (num_io_timeout > MAX_STATUS_IO_TIMEOUT) {
> > +                               cifs_server_dbg(VFS,
> > +                                               "Number of request timeouts exceeded %d. Reconnecting",
> > +                                               MAX_STATUS_IO_TIMEOUT);
> > +
> > +                               pending_reconnect = true;
> >                                 num_io_timeout = 0;
> > -                               continue;
> >                         }
> >                 }
> >
> > @@ -1113,6 +1119,11 @@ cifs_demultiplex_thread(void *p)
> >                         buf = server->smallbuf;
> >                         goto next_pdu;
> >                 }
> > +
> > +               /* do this reconnect at the very end after processing all MIDs */
> > +               if (pending_reconnect)
> > +                       cifs_reconnect(server);
> > +
> >         } /* end while !EXITING */
> >
> >         /* buffer usually freed in free_mid - need to free it here on exit */
> > --
> > 2.43.0
> >
> 
> These changes look good to me.
> Reviewed-by: Shyam Prasad N <sprasad@microsoft.com>

Thanks, now queued up.

greg k-h

