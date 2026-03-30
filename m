Return-Path: <stable+bounces-230992-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iHjlGS3lyWlC3QUAu9opvQ
	(envelope-from <stable+bounces-230992-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 04:51:25 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 774C9354E41
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 04:51:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A5E9F3002518
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 02:51:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E901D3815F9;
	Mon, 30 Mar 2026 02:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qwTzhzBI"
X-Original-To: stable@vger.kernel.org
Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com [74.125.224.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7178B3624AD
	for <stable@vger.kernel.org>; Mon, 30 Mar 2026 02:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774839077; cv=pass; b=ToMsej4wx0ITN6PG8wWyNVTFkajqV7O2TRmAuVfreEhs8oK/kxQbzGf+X4XljMsm5DqCEk2YI9ISC4D17YakCZKPY8IQFQ4iNWiP6GQnxRnNQbHXskik9hkwHD56SdYaFqSJOgtPAyQbLZWVhfI9cYmlLcS0V8vKVGU4WwcW+eo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774839077; c=relaxed/simple;
	bh=RNK/vnKu/pgZEBtVMkMLbuqixs2u1SksMaUAltp2QDM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=auUKxnVQ4F/h62OFQZREfnnZui/JzQX86sxaQT15FJDoTzqts9QjftSvkyy1qRhPHDIRUOCa8NS/uyVM3Vz25CrYBRU5UcsjmQrrI6pBerac9PBLhbrMnxP86ryrRS5TGgwURTJqxKYAFe/cJsQA92OVUKYQe0Hh5XEaDjq4CCg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qwTzhzBI; arc=pass smtp.client-ip=74.125.224.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-6501d32b04bso460193d50.2
        for <stable@vger.kernel.org>; Sun, 29 Mar 2026 19:51:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774839075; cv=none;
        d=google.com; s=arc-20240605;
        b=OLI4iO4SwY0R1YpwM7L10enQmTCVPfgDyBNvaoIwDqsN2yxwTG4fmizVzlupnigUgx
         beBiyzTWQ3fcGgLXPEFO/jhAqD+YCUNHnKnQOlnxtCl+KkHhKek2hF4ZuTldxeZgR7F/
         bCPrXtovfPJl7gAUIXR1znahsGIr6h338wcIsk3kvMOm4VdnztfQOaEqUQFwD+DKCamU
         LGGzYcIt+3OEJN3LnCHS7Ffe9qWILGdZ4LTBvyPQBoBYqHc4Vb5eek0SDtDZjxnhuVNo
         X7TNG6ad0g2UT0RvdyaV5IoWvEj60dB2xiK0LsIG6Yr2Vf+PwnuGVILRCfMNpo8QpGEn
         W1xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=L/pm9TpXLcvckJFncspSQ2WQQxlL1sYTEpU9KK49x3w=;
        fh=JPI7IMLC3vx0QD4Zrm1UXXKD89CCY1wGJfjwaGEfN80=;
        b=jYJp/KrerAAWzz9ArReRP01Wzp8r59duCfdoUdJSuPNVa5A2TxaKcj0dE22Ph/Yysp
         SYpFD71gLUgbmBno28FXu9b5KN6ACPiysu9nlPRBnqSTA4GmC+UeOJaxdGW4DWlM5Eyd
         SOHNIFvXgIy7DJ4tppf6wgRmmFZOjbJ06ilWPg3+a7UJ8/2QkuILL84RzLaVmzzyBc4H
         bxMxJFqPATaVZ6Dd1upWIZrb7Nv3N7Cnh0W1GLjR9OXSKNrhxQFXLqr5O5xO/qFMQU6y
         dPY/UdsB5Omz10PaT8vU5l+OmnFoT+fRKth3X8rZCDAzTMJuruT8MyVvUb/MQSljB47R
         QTYg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774839075; x=1775443875; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L/pm9TpXLcvckJFncspSQ2WQQxlL1sYTEpU9KK49x3w=;
        b=qwTzhzBICL0Muxb/f1s6PRi1tTWLc3aZ2kDwQR96UeR06WONd8UCSLo7j6+a6IggnC
         VveKGUipDYbN+Iel1SatJAHd3Fr3XoconQc15au0LIvyCrva6qHx5XX2pr9QRvDTndck
         qn1A7x47xNce7tibKXM3SkKl3QSZoO8TulrVrVICBCdFPdSU5s75r4VwBD/iFw8ZK/55
         DuCZPJ+gJ0svbAwQlclejOYX5NInUOADxbMZsp92yjnaGr1Bbw9iAZnoV34jKS0JDDFz
         6iaGc7aC7PwYfEtCPxP/XWfcVUl6YKrfp/QxXgUkg4m0G3SmOx1qrhE7DYBhWADg2400
         4xQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774839075; x=1775443875;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=L/pm9TpXLcvckJFncspSQ2WQQxlL1sYTEpU9KK49x3w=;
        b=hOvx4JGYDypYxVNZGAEFQmCuxE3dVcmIqIVfq2dCf5Hf+yGp0PkrpRR8cZiueemqmr
         Ry0M8HdfbIzjZ6VvzzQ/C0gNqDxxe+Dyfvjml91Jn1KNdb+flXGB8xMltwi31p6oNzVR
         +sW6KflbT1dIgN5EiGlMRM+gl628P41U0drwVa/4YiBHsl+h6xvaw4qITWNrHemNJDKb
         1p/E5uPszHIvX3NNCrZsG3jCmo584K49Pr0xLCyiQ3MIP2ihwIIv5XwF33NBCoShG9rG
         KiL14LFDcQoICEkKr1dn+iyxEOIfYVTDbq56yvBzOiaWvCKjgOrgZLHM8gHQTgMgMDlf
         xlQw==
X-Forwarded-Encrypted: i=1; AJvYcCWlJyqw/SP5Uwu5chslURqPza9KEkH6RvHOIsAYEK0KEGO7Y0ULLQ4RzF7jmvkQLo2yvyr2b6M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3efVZTqN9TMQcUlbdK5es0inZxSc3iOA2mp2dcOIeeA3wK+ss
	uD07AQ6IEpS17vOk+gQHZ4JXYW9ozzs+9waXoWyqtfLaDkTNw7HQkUQDetK4T/BfSHrzfFuiKlu
	BQql4CK9QCGsdS7XzZUrJ59L0mxwdbbM=
X-Gm-Gg: ATEYQzxujJ8kJApP7IwVCiPjWZXdeja2kgouAL/kUYepAo8lTXmnVU69TOiF0CDYFrt
	J7BfXgrO+o0/NsYk5eZDzZ5YtO03MuBueTG7caXH4ORNYzBommSyqAP95Lv6/eLoK03bz5o4IXh
	srpHrRPCCYZeJ10CKYfxBxZ0S1jE0D18OIXQa9fXzSjHNwNxpFM/X60dedg8VAv8p16gkQmak53
	kQKlz6E7PrhnLejE+to8r/0J1Qu0vHeX3UR/ks+hWH+vWliE0sjCt+XaEhBmdJPkrqvqocQxUuc
	3Ht3qeCFf7Tk4TclkohM
X-Received: by 2002:a05:690c:e092:b0:79b:d56a:a7c2 with SMTP id
 00721157ae682-79bde06b035mr114098427b3.48.1774839075368; Sun, 29 Mar 2026
 19:51:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260327131448.156177-1-zzzccc427@gmail.com> <acnS4iOihfWL4ay5@dread>
In-Reply-To: <acnS4iOihfWL4ay5@dread>
From: Cen Zhang <zzzccc427@gmail.com>
Date: Mon, 30 Mar 2026 10:51:03 +0800
X-Gm-Features: AQROBzD8lyNwGbcqekKHhTmk0Q4gpgVmHnWhnWcQE3GVt6kS1rEIV4i0Mce3u4g
Message-ID: <CAFRLqsXeK6Y_C8=afkxJoMmxtGn8p5HaSy5g5VYpa+gcA3RKiQ@mail.gmail.com>
Subject: Re: [PATCH] xfs: annotate lockless bli_flags access in buf item paths
To: Dave Chinner <dgc@kernel.org>
Cc: cem@kernel.org, linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	baijiaju1990@gmail.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-230992-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zzzccc427@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 774C9354E41
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Dave,

> When XFS_BLI_STALE is set in unpin, then by definition the buffer
> must be locked and the BLI referenced. [...]
> Hence we only care about the bli_flags when unpin has the only
> remaining reference to the bli, and in that case the read cannot be
> racing with anything else changing it's state.

Thank you for the detailed walkthrough.  You're right about several
things: READ_ONCE()/WRITE_ONCE() was the wrong tool here, the
WRITE_ONCE in xfs_buf_item_release() is useless since it's under
the buffer lock, and the tracepoint change doesn't matter.  I'm
dropping those.

However, I want to share the actual concurrent access evidence
before we decide on the remaining two reads:

  (1) xfs_buf_item_unpin:510 reads bli_flags
  (2) xfs_buf_item_committed:803 reads bli_flags

Both race with two different write paths:

  Write A: xfs_trans_dirty_buf:532  (bli_flags |=3D DIRTY|LOGGED)
           via new transaction on the same buffer
  Write B: xfs_buf_item_release:713 (bli_flags &=3D ~LOGGED|HOLD|ORDERED)
           via iop_committing on xlog_cil_commit path

The concurrent paths are:
  CPU 0: old checkpoint completing on workqueue
         =E2=86=92 xlog_cil_committed =E2=86=92 iop_committed / iop_unpin
  CPU 1: new transaction with the same buffer committing
         =E2=86=92 xlog_cil_commit =E2=86=92 iop_committing =E2=86=92 iop_r=
elease
         (or xfs_trans_dirty_buf during the transaction)

The comment at xlog_cil.c:1856 even acknowledges this:
  "the CIL checkpoint can race with us and we can run checkpoint
   completion before we've updated and unlocked the log items"

> IOWs, using READ_ONCE to indicate a data access race is -incorrect-
> in the cases where we actually use the result of the read.

Agreed.  For xfs_buf_item_unpin(), you're right that stale is
only consumed on the last-reference path where no concurrent writer
exists.  But the read at line 510 happens unconditionally _before_
atomic_dec_and_test(), so on the non-last-reference path it does
race with the writes listed above.  The value is discarded in that
case, so there's no semantic issue.

Rather than annotating a race whose result is unused, a cleaner fix
is to move the stale read to after the freed check, so the read
only occurs when we actually need the value -- at which point there
is no race:

    freed =3D atomic_dec_and_test(&bip->bli_refcount);
    ...
    if (!freed) { xfs_buf_rele(bp); return; }
  + stale =3D bip->bli_flags & XFS_BLI_STALE;

This eliminates the concurrent access entirely with no behavior
change.

> There is no consequential race here, either. Once an BLI is marked
> as an XFS_BLI_INODE_ALLOC_BUF under the buffer lock [...] that
> flag never gets cleared from bip->bli_flags.

Correct -- the bit being read (INODE_ALLOC_BUF) is never modified
by the concurrent writers, so the result is always correct.  But
the concurrent writes to other bits in the same word (Write A and
Write B above) do constitute a data access race on that memory
location.  Since the race is confirmed
benign, data_race() is the right annotation.

  - if ((bip->bli_flags & XFS_BLI_INODE_ALLOC_BUF) && ...)
  + if ((data_race(bip->bli_flags) & XFS_BLI_INODE_ALLOC_BUF) && ...)

So the v2 would be:
  - Move stale read in xfs_buf_item_unpin() after freed check
  - data_race() in xfs_buf_item_committed()
  - Drop everything else (WRITE_ONCE, tracepoint, release-side)

Does this sound reasonable?

Thanks,
Cen

