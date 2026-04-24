Return-Path: <stable+bounces-240558-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yO0dMWXs6mnCFgAAu9opvQ
	(envelope-from <stable+bounces-240558-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 06:07:01 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ED4D459A55
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 06:07:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AEC59300B746
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 04:06:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1794331AF31;
	Fri, 24 Apr 2026 04:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M9RbQ45/"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66265303A04
	for <stable@vger.kernel.org>; Fri, 24 Apr 2026 04:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777003618; cv=pass; b=SapwLyYq/RXavK+l243rTluVbi9KrasYeiKaaCmQdVkTkhY0JmtDMyPr2EmnbqenLpe5/vyygNNKxOKJPrOsiCut6f1pWmiFh965pA6nuRTaP7TWISTffdX9QgO3t2yPHemc8Y5fWFohw47zMqpgk0HhcOwd5AKv917MSYuobHk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777003618; c=relaxed/simple;
	bh=ZeMSoxm5J56pCcvQzGBEzz5ZDcItPYQcH5DkOuSS+uM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KSjT8OxLhHKpe4302XrJJb20U9sOmH9pmT5bKMZwstgLCOSfkkK8wJKBtOXFsNWwryqOUvHgfPqedUoI3PCAtTLsYNdvOE6NG27X9i0+h0fVl8Fahw8vPEWOFlgOxa/wtGLFvBB4wMowMem4AgUcr2k30sPQDOa1xt/XHj6qJq0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M9RbQ45/; arc=pass smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-676d8582a13so5702671a12.0
        for <stable@vger.kernel.org>; Thu, 23 Apr 2026 21:06:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777003616; cv=none;
        d=google.com; s=arc-20240605;
        b=jic3qLxoCwvijFzXNjOwhP3fLlTvDQYkRqb0qEsx6incDsSb2/QyqLfvYqlypEgV6r
         JScW1puNFg4PotLXlQ+s8wMdvyQs2w5VqvDtIzTtSHiEWZna1Y/HOdiSKXC92kOMnxGH
         vTGJEzWgMUdVBvI7XHHdu9FwiurxacmdsSh3h5H4ZMTmjvIZnehwmy6wh0+inl8Sq/pU
         mTd/13CmS4pd7YYKeMG7wi6csREC4FrwsQlLsGOHDGydqQUQVGxuCDGCNWboH13Wrar8
         Adp3wfkJsTCROpFwgXVnrym07w5cqqj+IZ1KZ2Ypzgj5fi+Oh0PUHVtxna/bI9OrBq1E
         uvdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=u1qEV7FDucr2Oma7YgmbpI0eIOoUHkUaFY9SQRTBH3U=;
        fh=1BS/HHx3P/UgmSlKGfaPVz1Rag7aKxam6/XnClsizhU=;
        b=LAeRtNtgWdvwfSzuuG7HjCmVovs6oZakVjLUZiNZ1upn57U+/Ya2Cvnx7nGwyYHFX5
         yoyr83jcku4WsuaXzCwdGT1JkPyQYnl1MqCDexi6kGQ+jch6JgsRiEhQE1GEqIJ9WrgL
         VVXREH4VpdE8gu4op+xQizhqwvlfpMsjF49yttaRcwjCcOiR6/VvuuGbX3ANB0stXYJO
         Pbqrb8f2b7wi2QigzkLH7+686/+i1Lhb02JIneqk0Ar3SC5ENrkXQkg/gXf7gwbLt7Wl
         jM5Oe7z6+mxv7U0f0evVa1GIwFVYUuNpijLCjeBUY4G1wbjmjdlzVLQwBQRxjxTaRr3T
         x7Mg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777003616; x=1777608416; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u1qEV7FDucr2Oma7YgmbpI0eIOoUHkUaFY9SQRTBH3U=;
        b=M9RbQ45/sv5qLxDA1Pos04z/gwcCipJEQvCzpcLXFFDuWeHC7cy3s4ZTvX7RBs5UkT
         APpMILWsMp0+x1WrQgEdWfCTVhqXHQe4uEJumstRW8U3hvKkq+AGGMjJa8nKgi2hV0x2
         WIU1poisXsBJZVzZnfOWVcxWI9N0GEuaQHd6AKbUcJQatAWn1poAgxCTQZW9Swdvxt31
         YOPvQ8FcYn9Z4+xcJvqmYPL1ROhQynSWogOooSYjDSDl0axYyq9VEKtBfpCBjuOMJ3M1
         6yO5UaBOwEtdOUhYomQir0u9rakQGbvDh/qef0lETKgfT64/czMPHFmGKnGnjAK7JIfE
         ZK0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777003616; x=1777608416;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=u1qEV7FDucr2Oma7YgmbpI0eIOoUHkUaFY9SQRTBH3U=;
        b=m2mR7/M5ZyBCjlS/inA6KTJmIQE3UbVoYsooFSHymMvfggD+8jNCjDoFOQT2DZD2lw
         ANMB1QjSJKjECJSqtYFynt9cpoABUHmpxRk3aow1k7gQX1jsbY6DtVZSDfwfiPpjncfM
         79l9W/OHBmad+EabMA+5ZmiYjhCo6NLaoapYzVB6WzKOvIPcVfoOOkDezldMYqkcxvQA
         eg4nVP9mPwlSPEg7ZllOjS4osguNJqhGd7wgzHHQZ5dTGxeO2fs0yOvQ5+gKo/zNyqxr
         oegVsBT5PGe9opQb1sJ0W0bUy0GvNF4X1pJTZqB8lonwFX/TK+fx5RvXBejSDVqUfq0B
         s1gA==
X-Forwarded-Encrypted: i=1; AFNElJ8gFpGR/qUWcSVvHM5VdeHMpAACFedAOjpo09WPrClGmOczN7MeeO6/4U+pm8QB9MdGsS75Rt0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoA70pIZNCwtG2fTZZE9q1aafAicYlf6zK/xHIT3gtWUplRT1g
	wbFU02KqMyCse+a4asZnI5uyM9J3/rWDzCp0PvoF4JLuES9dNEmKwWrJYppUQyuK/FnghJJZd3m
	XzsoDB6itvdVFI1hifJsJPL/HEYITlijKIA==
X-Gm-Gg: AeBDiev6cg4c7RQGbRt6x+jw/dS+p/9NkbG4m3iWvX+JNHa6bj1dU4tceIVcnePBetT
	ATyo7ebD6hJ3qNRt4Mb1Mu10XstgT3kVwYTqOcurLtel0MmySFMy4C1aJ4y3KHxET9Wk21GXOnp
	z2MRa0J/6YPzxjUqcbUFTN7ObAVB9uHmzkDsDjV6GWEET1TYFiWgjdVk/owWHiYpX+46MNg6fO4
	7/qy0MqcFP86480ftaotsxxn/T/DypWcne2Q6S3DGjnpu03/7hR2mZjODBB7amT6WlfRhOK8FeD
	GtGv0tdGJjoRDlxu
X-Received: by 2002:a17:907:3f0f:b0:bab:7930:db48 with SMTP id
 a640c23a62f3a-bab79401ea6mr498302066b.46.1777003615416; Thu, 23 Apr 2026
 21:06:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260421063955.99164-1-sprasad@microsoft.com> <20260421063955.99164-2-sprasad@microsoft.com>
 <CAGypqWzrOmR6rUimbBJa9qJ-=+KJFzccMjere9dX=KwWeDFe+A@mail.gmail.com>
In-Reply-To: <CAGypqWzrOmR6rUimbBJa9qJ-=+KJFzccMjere9dX=KwWeDFe+A@mail.gmail.com>
From: Shyam Prasad N <nspmangalore@gmail.com>
Date: Fri, 24 Apr 2026 09:36:43 +0530
X-Gm-Features: AQROBzAJ-73VnnQjn9jxamNohqWFvDhzqHJpUDI2Ld9Tk85kL8Hk85ywSY7ptQk
Message-ID: <CANT5p=rJ28LCOT1qcn9Xtcutq4mJB9t+jX9e79fDOXg0cHh0Ow@mail.gmail.com>
Subject: Re: [PATCH v2 2/7] cifs: abort open_cached_dir if we don't request leases
To: Bharath SM <bharathsm.hsk@gmail.com>
Cc: linux-cifs@vger.kernel.org, smfrench@gmail.com, pc@manguebit.org, 
	bharathsm@microsoft.com, dhowells@redhat.com, henrique.carvalho@suse.com, 
	ematsumiya@suse.de, Shyam Prasad N <sprasad@microsoft.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 1ED4D459A55
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-240558-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,manguebit.org,microsoft.com,redhat.com,suse.com,suse.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nspmangalore@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[10];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid]

On Tue, Apr 21, 2026 at 8:56=E2=80=AFPM Bharath SM <bharathsm.hsk@gmail.com=
> wrote:
>
> On Mon, Apr 20, 2026 at 11:40=E2=80=AFPM <nspmangalore@gmail.com> wrote:
> >
> > From: Shyam Prasad N <sprasad@microsoft.com>
> >
> > It is possible that SMB2_open_init may not set lease context based
> > on the requested oplock level. This can happen when leases have been
> > temporarily or permanently disabled. When this happens, we will have
> > open_cached_dir making an open without lease context and the response
> > will anyway be rejected by open_cached_dir (thereby forcing a close to
> > discard this open). That's unnecessary two round-trips to the server.
> >
> > This change adds a check before making the open request to the server
> > to make sure that SMB2_open_init did add the expected lease context
> > to the open in open_cached_dir.
> >
> > Cc: <stable@vger.kernel.org>
> > Signed-off-by: Shyam Prasad N <sprasad@microsoft.com>
> > ---
> >  fs/smb/client/cached_dir.c | 7 +++++++
> >  1 file changed, 7 insertions(+)
> >
> > diff --git a/fs/smb/client/cached_dir.c b/fs/smb/client/cached_dir.c
> > index 04bb95091f498..e9917e5204b00 100644
> > --- a/fs/smb/client/cached_dir.c
> > +++ b/fs/smb/client/cached_dir.c
> > @@ -286,6 +286,13 @@ int open_cached_dir(unsigned int xid, struct cifs_=
tcon *tcon,
> >                             &rqst[0], &oplock, &oparms, utf16_path);
> >         if (rc)
> >                 goto oshr_free;
> > +
> > +       if (oplock !=3D SMB2_OPLOCK_LEVEL_II) {
> > +               rc =3D -EINVAL;
> > +               cifs_dbg(FYI, "unexpected oplock level %d for cached di=
rectory\n", oplock);
> Should we reword the log from "'unexpected' oplock level for cached
> directory" to something like
> lease not available for cached dir.? Considering  the client itself
> might be disabling oplock temporarily.
> "unexpected" might look misleading.

Hi Bharath,
Thanks for the review. Will make the change.

>
> > +               goto oshr_free;
> > +       }
> > +
> >         smb2_set_next_command(tcon, &rqst[0]);
> >
> >         memset(&qi_iov, 0, sizeof(qi_iov));
>
> Other than the above minor comment, Changes look good to me.
> Reviewed-by: Bharath SM <bharathsm@microsoft.com>



--=20
Regards,
Shyam

