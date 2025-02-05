Return-Path: <stable+bounces-112276-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EC85A28369
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 05:42:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BEB43163C61
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 04:42:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5DD9215778;
	Wed,  5 Feb 2025 04:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="QNQaprYg"
X-Original-To: stable@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 869E220FAA0
	for <stable@vger.kernel.org>; Wed,  5 Feb 2025 04:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738730525; cv=none; b=V7wAp7skreOo2tszXONVNJpBUb6vT65IaxiDTQEzToez1FbN5p/mMyN0X6rqBUiLpY5Ye+F6QXhO3vd/tHlMPGZDhhoP6vRC/WJcuBcg4AYhqbXJLw3ppq2nzuCM2gbDXiVzyjIvBGTGhqHebfwrBKyjl6O737VbG1kazdOwtU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738730525; c=relaxed/simple;
	bh=64SQosiOCxOdYvT4XbtwmqxP7SLL3kIIkHkxT80x6tQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AMiTeqrz3SPeDwYUUwtjoZKqsNhiHNdwnszgaMsHLrxyJCm0BBVIxkutoSCReoYGNUO7Zjss7dN/G3oLbYSIFPqQSHRmkEKjTlCuzEhtvtgljUdO7YxQc1TKT8Jm+6l79THFKQGHzMIlF76iNDwRZxq4ekYWBOM63nJDGaetWn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=QNQaprYg; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-123-53.bstnma.fios.verizon.net [173.48.123.53])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 5154fsLv019785
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 4 Feb 2025 23:41:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1738730516; bh=Dd9XXMDav6Hs9NCwS6iRnr/lA65SEisNRunHxhd51Ws=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=QNQaprYgXZHkcdQ1zU3/dHQEAQQlfkJGHmoxMi74WYq95y0kNIapOpvbLs6Qb6PYD
	 Ntqc96q+RRzYLHCzYXs619TWAWz/7SQhAPUG+Ueb+8+etqYGOFmbl55cTmD9ANkE+e
	 MjLtCXM6RTOE5ButlE0+9mxeh3Y++eY7G41rzF5we53qqq9aB7MebQek4gjefcbrzN
	 s7RTpcvHrsOTi/cfObGOtTj34WAq3ZN8wTijHBbznsAWzONJ51TejPBuR9mZDN/F5g
	 ZxFM9tbOqQpQfQERZNcvpTku3x/PCvY3DsPIuek6dw2EI0OS4oPmJ/MRxnoArdFldk
	 zER3KC+bAzHAQ==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id 83A3115C013F; Tue, 04 Feb 2025 23:41:54 -0500 (EST)
Date: Tue, 4 Feb 2025 23:41:54 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Daniel Rosenberg <drosen@google.com>
Cc: Todd Kjos <tkjos@google.com>, Greg KH <gregkh@linuxfoundation.org>,
        stable <stable@vger.kernel.org>,
        Android Kernel Team <kernel-team@android.com>
Subject: Re: f2fs: Introduce linear search for dentries
Message-ID: <20250205044154.GB909029@mit.edu>
References: <CA+PiJmR3etq=i3tQmPLZfrMMxKqkEDwijWQ3wB6ahxAUoc+NHg@mail.gmail.com>
 <2025020118-flap-sandblast-6a48@gregkh>
 <CAHRSSExDWR_65wCvaVu3VsCy3hGNU51mRqeQ4uRczEA0EYs-fA@mail.gmail.com>
 <CA+PiJmT-9wL_3PbEXBZbFCBxAFVnoupwcJsRFt8K=YHje-_rLg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="qKgqDoNG780PGj9N"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+PiJmT-9wL_3PbEXBZbFCBxAFVnoupwcJsRFt8K=YHje-_rLg@mail.gmail.com>


--qKgqDoNG780PGj9N
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Mon, Feb 03, 2025 at 03:07:10PM -0800, Daniel Rosenberg wrote:
> On Sat, Feb 1, 2025 at 9:06 AM Todd Kjos <tkjos@google.com> wrote:
> >
> > Before we can bring back the reverted patch, we need the same fix for
> > ext4. Daniel, is there progress on that?
> >
> Last I knew, Ted had a prototype patch for that, not sure what the
> current status of it is. I'm also not sure whether the unicode patch
> is being relanded, or if there's a different fix in the works there.

Between travel and an emergency at work, I haven't had time to create
the script to create a test file system to verify the prototype patch.
It turns out this is quite diffisult!

I finally managed to create a script which demonstrates why the revert
was necessary, but it wasn't enough to demonstrate why a further patch
is needed.  I think I know what I need to do, but it's a mess and I've
already wasted hours and hours in this.

Do you have a relible script to generate a test file system.  This is
what I have so far, but as I said, it's not quite good enough...

					- Ted


--qKgqDoNG780PGj9N
Content-Type: text/plain; charset=utf-8
Content-Disposition: attachment; filename=unicode-hijinks
Content-Transfer-Encoding: 8bit

#!/bin/bash
#
# Generate a test file system to verify the handling of mess with
# Uniode insanity known as "inorable code points".
#
# I - ignore/no-ignore invisible "evil" Unicode characters
# E -encrypt/no-encrypt
# H - htree/no-htree
# F - case-fold/no-casefold
#
# Run this with first with a kernel new to include the commit
# 231825b2e1ff ("Revert "unicode: Don't special case ignorable code
# points".  Then boot a kernel checked out to commit 5c26d2f1d3f5
# ("unicode: Don't special case ignorable code points") and run this
# script with the -I option.
#
# To test the file system, boot the kernel you want to test, and copy
# the test file system imge to /tmp/foo.img, and then run the commands:
#
#    unicode-hijinks -m
#    unicode-hijinks -l

FS=/tmp/foo.img
I=no-I

TEST_RAW_KEY=
for i in {1..64}; do
	TEST_RAW_KEY+="\\x$(printf "%02x" $i)"
done
# Key identifier: HKDF-SHA512(key=$TEST_RAW_KEY, salt="", info="fscrypt\0\x01")
TEST_KEY_IDENTIFIER="69b2f6edeee720cce0577937eb8a6751"

case "$1" in
    -I)
	I=I
	;;
    -m)
	mount /tmp/foo.img /mnt
	echo -ne "$TEST_RAW_KEY" | xfs_io -c add_enckey /mnt
	exit 0
	;;
    -l)
	for i in I no-I ; do
	    for e in E no-E ; do
		for f in F no-F ; do
		    for h in H no-H ; do
			ls -il /mnt/$i/$e/$f/$h/❤️
			ls -il /mnt/$i/$e/$f/$h/❤
		    done
		done
	    done
	done
	exit 0
	;;
    "") :
	;;
    *)
	echo "usage: unicode-hijinks -I|-m|-l"
	exit 1
esac

function gen_files ()
{
    echo "red heart" > ❤️
    echo "black heart" > ❤
}

function mk_htree ()
{
    seq 1 1000 | xargs -I Z touch XXXXXXXXXXXXXXXXXXX-Z
}

function mk_casefold ()
{
    chattr +F .
}

function mk_htree_set ()
{
    mkdir no-H ; cd no-H ; gen_files ; cd ..
    mkdir H ; cd H ; mk_htree ; gen_files ; cd ..
}

function mk_htree_and_casefold ()
{
    mkdir no-F; cd no-F; mk_htree_set ; cd ..
    mkdir F; cd F ; mk_casefold ; mk_htree_set ; cd ..
}


if [ "$I" = "no-I" ] ; then
    mke2fs -t ext4 -Fq -b 1024 -N 8192 -O casefold,encrypt $FS 4M
fi
mount $FS /mnt

echo -ne "$TEST_RAW_KEY" | xfs_io -c add_enckey /mnt
xfs_io -c "enckey_status $TEST_KEY_IDENTIFIER" /mnt
cd /mnt
mkdir $I
cd $I
mkdir no-E
cd no-E
mk_htree_and_casefold
cd /mnt
cd $I
mkdir E
xfs_io -c "set_encpolicy $TEST_KEY_IDENTIFIER" E
cd E
mk_htree_and_casefold
cd /
umount /mnt



--qKgqDoNG780PGj9N--

