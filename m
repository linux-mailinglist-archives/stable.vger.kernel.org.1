Return-Path: <stable+bounces-10620-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 94B7782CA93
	for <lists+stable@lfdr.de>; Sat, 13 Jan 2024 09:47:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 492C61F22FBF
	for <lists+stable@lfdr.de>; Sat, 13 Jan 2024 08:47:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FB387E9;
	Sat, 13 Jan 2024 08:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Xn4+q1vH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA15E36F;
	Sat, 13 Jan 2024 08:47:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7154C433C7;
	Sat, 13 Jan 2024 08:47:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705135635;
	bh=KdwxMYv7o6pw1GOXq0l7vgitfs+43uc1Npe8Z2Rl8oM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Xn4+q1vHMeOlxECUgBICafgoMdYugGECJ4PwI1kPXG8CqKUoCeReujvgY9BGaoOcf
	 YwpCXl8Hu/osgZgQetYTPwkcC8Xhut4ms6NQ3I5ZKU8ATxnfgNinPCHKxblFL19ZlI
	 OanmmVNvDRgVSCrBP/mA7O8zp3cHA1DbTPbcdhZU=
Date: Sat, 13 Jan 2024 09:47:12 +0100
From: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To: Steve French <smfrench@gmail.com>
Cc: David Howells <dhowells@redhat.com>,
	Salvatore Bonaccorso <carnil@debian.org>,
	Paulo Alcantara <pc@manguebit.com>,
	Shyam Prasad N <nspmangalore@gmail.com>,
	Rohith Surabattula <rohiths.msft@gmail.com>,
	Matthew Wilcox <willy@infradead.org>,
	Jeff Layton <jlayton@kernel.org>,
	Steve French <stfrench@microsoft.com>,
	"Jitindar Singh, Suraj" <surajjs@amazon.com>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	"stable-commits@vger.kernel.org" <stable-commits@vger.kernel.org>,
	stable@vger.kernel.org, linux-cifs@vger.kernel.org,
	Linux regressions mailing list <regressions@lists.linux.dev>
Subject: Re: [Regression 6.1.y] From "cifs: Fix flushing, invalidation and
 file size with copy_file_range()"
Message-ID: <2024011302-nail-uncombed-932a@gregkh>
References: <2023121124-trifle-uncharted-2622@gregkh>
 <a76b370f93cb928c049b94e1fde0d2da506dfcb2.camel@amazon.com>
 <ZZhrpNJ3zxMR8wcU@eldamar.lan>
 <8e59220d-b0f3-4dae-afc3-36acfa6873e4@leemhuis.info>
 <ZZk6qA54A-KfzmSz@eldamar.lan>
 <13a70cc5-78fc-49a4-8d78-41e5479e3023@leemhuis.info>
 <ZZ7Dy69ZJCEyKhhS@eldamar.lan>
 <2024011115-neatly-trout-5532@gregkh>
 <2162049.1705069551@warthog.procyon.org.uk>
 <CAH2r5mtBSvp9D8s3bX7KNWjXdTuOHPx5Z005jp8F5kuJgU3Z-g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAH2r5mtBSvp9D8s3bX7KNWjXdTuOHPx5Z005jp8F5kuJgU3Z-g@mail.gmail.com>

On Fri, Jan 12, 2024 at 11:20:53PM -0600, Steve French wrote:
> Here is a patch similar to what David suggested.  Seems
> straightforward fix.  See attached.
> I did limited testing on it tonight with 6.1 (will do more tomorrow,
> but feedback welcome) but it did fix the regression in xfstest
> generic/001 mentioned in this thread.

Thanks, now queued up!

greg k-h

