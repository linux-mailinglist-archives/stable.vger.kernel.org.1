Return-Path: <stable+bounces-196993-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1851CC89411
	for <lists+stable@lfdr.de>; Wed, 26 Nov 2025 11:22:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E8E974E5E44
	for <lists+stable@lfdr.de>; Wed, 26 Nov 2025 10:21:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11216313551;
	Wed, 26 Nov 2025 10:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="h+5HUmF/"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D093D316901
	for <stable@vger.kernel.org>; Wed, 26 Nov 2025 10:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764152416; cv=none; b=LAgk1Inq+aaz9462ES1aWG7/fla3eTg1pTwTWaECiPI+ikVFz1EaBw8ZAiwnSTWlKunk4+H7cmajWwGccdXdW1ByXvbcSBhw+9PpOx28FiEBB5OozyS2ikgUgbNBLZtnZzk0HSS0kjyhCmx0LpwwVZ6L0NX18y8LUryrjukG218=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764152416; c=relaxed/simple;
	bh=WQRWNn3JBPfHioQ7NM+c7ka/KopAlY2XsDD5EIgXsQ0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MDF8VjubiH8K0D5kRV3l2zKRad/OfPnGxt84KNTwVa9LV+S0aZ1GwBM1/SRpNtIQahGHMaP0K4jZbL5jZZ5Z33FcpgNINp3sHjzUQutlpT0DOPGBZE//L5vQfxzhDHf9JUIW2sOqTF46PeTBMOKyKtZ5YCHt2wxKRwfpxzsbdcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=h+5HUmF/; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4ed82e82f0fso61975141cf.1
        for <stable@vger.kernel.org>; Wed, 26 Nov 2025 02:20:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1764152410; x=1764757210; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=SMlngkIvl5JGEozo1jxZDpYbFOsUahvrlyWvC/X9pBo=;
        b=h+5HUmF/gbFOwbaqH7mZawA8ygEANmi5XPlrOwqfRz02CBsOwuOgDrjpoXTxZ0JZiD
         1WqNQ8LCN2vxt8MZHC/RDSbD6dFZhe8cGS5GF+4mrr/1/uFUmSrv57h5QvsHJBTyyyK5
         BCbbXwBfZlgbcmUft+UuANn7SsgHj+efXlLv0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764152410; x=1764757210;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SMlngkIvl5JGEozo1jxZDpYbFOsUahvrlyWvC/X9pBo=;
        b=ouPWE5YAtYmnFQpkj0PBtG89s6dDSiABxMZgt45QVCwmsmE/7mrM/lE1H2m6sW++rM
         ZPiTw0rgQhCFAdu0/R7VX3Zo2PHSs7+oIljAT0lt7OPT/NLhCBl13kCTov1F6aV4lH0D
         7JQG9C25dhOOIlntmXrFomBvmay6yD1r8dkndGQ17WRH7a6qhZSf/iuzVyjjquxjpKjf
         rt3STk9YAq7bOZvnTs28MlERAuBdhud+Helu6xHjsca7hfC0E4urpIfp4G1/z5FvvdEr
         rSBE7KUNO3OIPve6PFbQIXGZdqInjqnXZ3J+huU7WQA/QN9ZRIZlt8zc4THiocriTAse
         G6SQ==
X-Forwarded-Encrypted: i=1; AJvYcCWneeHhudJpo4vfxjYO+KFSzjNFSAFa9xW+GZG+NSyvEYlRGVbtI5si+wbMWCSKdhaW5EyNGyw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtKMw5J0oGLvgwgxpN5yCpsHO1l0M1uYRNSZJn3/ItUwrRp3hE
	rI9WDBMX1OYe0GfHn8qQi5IuwZOy3BYBDAY0CVDRGQ6JjbyegJET9fypPKM6iC6KtnxshuRonUW
	6/A5TqcsQPLtDBIIDSA4EakOtlc0nEEAoFRkvXeUh5g==
X-Gm-Gg: ASbGncsICl8cBAyLVXjJBy194am/C8+8Zhqkwyy/CLN00JZbh2aefUnvvVSzKLR/nq2
	7fSAeeU30e7YqMLNwoJkE8U/HgnK+TTP+Mv+5sUKrg0DWeTyPQQZLpq02X5kbLo3UvYba1NyddN
	3kHDrHATfL6jNSq9H9Lt+QB3EJTkV7PB/axkzpFxsZu0TVH9g2sgVdKj3r59atZufh+j8R+A6KF
	Ta8/Kz5qNYNBXWsfW1vVLZ2WnDDEjVzNs+Wu0GrMeqCRPpD8cAj13mrljWOQ8j1XIh/fg==
X-Google-Smtp-Source: AGHT+IEnogSp3RkM1aqfD2IIA6sf5bROWejdu4XbeOX5zYMUXNneObTvydXkEeizuFkGuY86XncpCAPksW/LZ6kZV48=
X-Received: by 2002:ac8:5887:0:b0:4ee:1e95:af68 with SMTP id
 d75a77b69052e-4ee58869cc8mr232624171cf.36.1764152410434; Wed, 26 Nov 2025
 02:20:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251120184211.2379439-1-joannelkoong@gmail.com>
 <20251120184211.2379439-3-joannelkoong@gmail.com> <5c1630ac-d304-4854-9ba6-5c9cc1f78be5@kernel.org>
 <CAJnrk1Zsdw9Uvb44ynkfWLBvs2vw7he-opVu6mzJqokphMiLSQ@mail.gmail.com>
 <f8da9ee0-f136-4366-b63a-1812fda11304@kernel.org> <CAJnrk1aJeNmQLd99PuzWVp8EycBBNBf1NZEE+sM6BY_gS64DCw@mail.gmail.com>
In-Reply-To: <CAJnrk1aJeNmQLd99PuzWVp8EycBBNBf1NZEE+sM6BY_gS64DCw@mail.gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 26 Nov 2025 11:19:59 +0100
X-Gm-Features: AWmQ_bnDs-zI6IGEuS8Bbkec8ad8AjyVcDCWKJHD7VX2hg0God0fyW2FOWPEJEc
Message-ID: <CAJfpegvH=5bA3B=6Mkjs_X_RtXV+=bCnGCV7Oc_-rAy38-uZ1A@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] fs/writeback: skip inodes with potential writeback
 hang in wait_sb_inodes()
To: Joanne Koong <joannelkoong@gmail.com>
Cc: "David Hildenbrand (Red Hat)" <david@kernel.org>, akpm@linux-foundation.org, linux-mm@kvack.org, 
	shakeel.butt@linux.dev, athul.krishna.kr@protonmail.com, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 25 Nov 2025 at 02:10, Joanne Koong <joannelkoong@gmail.com> wrote:

> Prior to the changes added in commit 0c58a97f919c ("fuse: remove tmp
> folio for writebacks and internal rb tree"), fuse didn't ensure that
> data was written back for sync. The folio was marked as not under
> writeback anymore, even if it was still under writeback.

This is the main point.  Fuse has existed for 20 years without data
integrity guarantees.  Reverting to that behavior is *not* a
regression, it's simply a decades old bug.   And solving that bug is
darn hard, which is why it's not an option at this point.

One idea to limit the scope of this revert is to constrain it to
suspend.  I'm not sure how easy or ugly that might be.

Thanks,
Miklos

