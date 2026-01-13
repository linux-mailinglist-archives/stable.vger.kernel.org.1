Return-Path: <stable+bounces-208231-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A231D16C31
	for <lists+stable@lfdr.de>; Tue, 13 Jan 2026 07:08:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 12DAA3017640
	for <lists+stable@lfdr.de>; Tue, 13 Jan 2026 06:08:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84F6D30C61C;
	Tue, 13 Jan 2026 06:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fnnas-com.20200927.dkim.feishu.cn header.i=@fnnas-com.20200927.dkim.feishu.cn header.b="Nz3GxoVG"
X-Original-To: stable@vger.kernel.org
Received: from sg-1-14.ptr.blmpb.com (sg-1-14.ptr.blmpb.com [118.26.132.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA09BA41
	for <stable@vger.kernel.org>; Tue, 13 Jan 2026 06:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=118.26.132.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768284529; cv=none; b=Rn+XVKhY2TzBHMhoxVboeKQp3OWbY5bGvmNkm5noIYj3Qo/OVDlv4hQHGqvFaCc7gQvFP6+tgvZjW81a76jGIcAlTNM7u0zNe8ufAecyqAnxbC/CrL8RZJQN+bQF1dHA6KH5lS2gmXLEPFkdUi5dFemiInfwt5TOuqM6RMWwQ0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768284529; c=relaxed/simple;
	bh=48i/oM0m20Fa/E5ZInxPzd49ab3SYrbzEFwwLNRgHVM=;
	h=To:In-Reply-To:Cc:Content-Type:References:From:Subject:Message-Id:
	 Mime-Version:Date:Content-Disposition; b=Ib7bpG9Z9XmATLPmcE51zu9MluvvUdsgnzjH1ESxBb18vyVlMtSuA3FD3XQctceXvN27P141/deUwNb4OMUrOGx3xkPD1RcAQ3AnDitevPeknpal+FFxgSaz5wrF+JOxSQCtf+ejYJixM/viMbRJCYqK7JqSD9CvEzTLHdeGNQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fnnas.com; spf=pass smtp.mailfrom=fnnas.com; dkim=pass (2048-bit key) header.d=fnnas-com.20200927.dkim.feishu.cn header.i=@fnnas-com.20200927.dkim.feishu.cn header.b=Nz3GxoVG; arc=none smtp.client-ip=118.26.132.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fnnas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fnnas.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=fnnas-com.20200927.dkim.feishu.cn; t=1768284511;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=96RErVkfp36Nx40VdssBFa2QUyXyMwnuul1HKFEGZNA=;
 b=Nz3GxoVG1jouyuV3hRP92KaOwPDJHgQPjWt8suvH9CG/Un8HBOp5elm8dJQ3XRPT9X/RXE
 nkeHbm7ROeASTkmD1HmeO8snHCIrEPSnaM1x0Y0cumuR+5TYdW1APBLjMxKtT3f1twrn+P
 OW965/BbLNVDQBpH+PjzOydbI6x4808Tr0NlD+fNDzU3m1RTmBiQp+bBGC4KR6UGwqWExu
 Pm7A5wkW9zRNVexy62NSmVH6ed2kikdNP2jL8g5UQFjUqL64WN1oferXJYloBrwJxhvmBF
 p7C9TaLtf/oPuUckZzcGKnQAhRr++vAjDWyZJucZpB11EJGV1XmosHGOgavwtw==
To: "Kent Overstreet" <kent.overstreet@linux.dev>
Received: from studio.local ([120.245.64.3]) by smtp.feishu.cn with ESMTPS; Tue, 13 Jan 2026 14:08:28 +0800
In-Reply-To: <aWU2mO5v6RezmIpZ@moria.home.lan>
Cc: <stable@vger.kernel.org>, <stable-commits@vger.kernel.org>, 
	<zhangshida@kylinos.cn>
Content-Transfer-Encoding: quoted-printable
X-Original-From: Coly Li <colyli@fnnas.com>
Content-Type: text/plain; charset=UTF-8
References: <20260112172345.800703-1-sashal@kernel.org> <aWU2mO5v6RezmIpZ@moria.home.lan>
X-Lms-Return-Path: <lba+26965e15d+697ecc+vger.kernel.org+colyli@fnnas.com>
From: "Coly Li" <colyli@fnnas.com>
Subject: Re: Patch "bcache: fix improper use of bi_end_io" has been added to the 6.6-stable tree
Message-Id: <aWXgStXQyV38uz7o@studio.local>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Date: Tue, 13 Jan 2026 14:08:27 +0800
Content-Disposition: inline

On Mon, Jan 12, 2026 at 01:01:52PM +0800, Kent Overstreet wrote:
> On Mon, Jan 12, 2026 at 12:23:45PM -0500, Sasha Levin wrote:
> > This is a note to let you know that I've just added the patch titled
> >=20
> >     bcache: fix improper use of bi_end_io
> >=20
> > to the 6.6-stable tree which can be found at:
> >     http://www.kernel.org/git/?p=3Dlinux/kernel/git/stable/stable-queue=
.git;a=3Dsummary
> >=20
> > The filename of the patch is:
> >      bcache-fix-improper-use-of-bi_end_io.patch
> > and it can be found in the queue-6.6 subdirectory.
> >=20
> > If you, or anyone else, feels it should not be added to the stable tree=
,
> > please let <stable@vger.kernel.org> know about it.
>=20
> Yeah, this is broken.
>=20
> Coly, please revert this.
>

Yes, let me do it.

Although I didn=E2=80=99t ack this patch, I read the patch and thought it w=
as
fine, yes my fault too.

This faulty patch didn=E2=80=99t trigger issue on my testing machine, I gue=
ss
it was because on simple bcache setup, re-enter bio_endio() happenly
didn't actually redo things other than calling bio->bi_end_io().

I will post a revert commit to Jens.

This patch is part of the patch set to address race around bio chain
handling. Then Shida please continue to find a better version on the
fix.

Coly Li
=20
> >=20
> >=20
> >=20
> > commit 81e7e43a810e8f40e163928d441de02d2816b073
> > Author: Shida Zhang <zhangshida@kylinos.cn>
> > Date:   Tue Dec 9 17:01:56 2025 +0800
> >=20
> >     bcache: fix improper use of bi_end_io
> >    =20
> >     [ Upstream commit 53280e398471f0bddbb17b798a63d41264651325 ]
> >    =20
> >     Don't call bio->bi_end_io() directly. Use the bio_endio() helper
> >     function instead, which handles completion more safely and uniforml=
y.
> >    =20
> >     Suggested-by: Christoph Hellwig <hch@infradead.org>
> >     Reviewed-by: Christoph Hellwig <hch@lst.de>
> >     Signed-off-by: Shida Zhang <zhangshida@kylinos.cn>
> >     Signed-off-by: Jens Axboe <axboe@kernel.dk>
> >     Signed-off-by: Sasha Levin <sashal@kernel.org>
> >=20
> > diff --git a/drivers/md/bcache/request.c b/drivers/md/bcache/request.c
> > index a9b1f3896249b..b4059d2daa326 100644
> > --- a/drivers/md/bcache/request.c
> > +++ b/drivers/md/bcache/request.c
> > @@ -1090,7 +1090,7 @@ static void detached_dev_end_io(struct bio *bio)
> >  	}
> > =20
> >  	kfree(ddip);
> > -	bio->bi_end_io(bio);
> > +	bio_endio(bio);
> >  }
> > =20
> >  static void detached_dev_do_request(struct bcache_device *d, struct bi=
o *bio,
> > @@ -1107,7 +1107,7 @@ static void detached_dev_do_request(struct bcache=
_device *d, struct bio *bio,
> >  	ddip =3D kzalloc(sizeof(struct detached_dev_io_private), GFP_NOIO);
> >  	if (!ddip) {
> >  		bio->bi_status =3D BLK_STS_RESOURCE;
> > -		bio->bi_end_io(bio);
> > +		bio_endio(bio);
> >  		return;
> >  	}
> > =20
> > @@ -1122,7 +1122,7 @@ static void detached_dev_do_request(struct bcache=
_device *d, struct bio *bio,
> > =20
> >  	if ((bio_op(bio) =3D=3D REQ_OP_DISCARD) &&
> >  	    !bdev_max_discard_sectors(dc->bdev))
> > -		bio->bi_end_io(bio);
> > +		detached_dev_end_io(bio);
> >  	else
> >  		submit_bio_noacct(bio);
> >  }

