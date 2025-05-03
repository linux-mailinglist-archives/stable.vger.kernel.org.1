Return-Path: <stable+bounces-139526-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CE5A1AA7DD8
	for <lists+stable@lfdr.de>; Sat,  3 May 2025 03:12:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 290957B7DD6
	for <lists+stable@lfdr.de>; Sat,  3 May 2025 01:11:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0FFE282E1;
	Sat,  3 May 2025 01:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="gBgSgzZW"
X-Original-To: stable@vger.kernel.org
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C18912904
	for <stable@vger.kernel.org>; Sat,  3 May 2025 01:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746234759; cv=none; b=qMcKb5EYHAF3E7dgPJQ6vQxNXVzHi9WWAlJqEqxZPyP739CEoKw3I9bseFzK/7c2yu9lRjsVvQVE8EaE6tpDC4nB4FfQl/IoT0Lx7wI6/FCGWqwuNP0LnDIvDmRDGf3Nf0lQBpYL+5OQ6HKxbEjsgEnD78OYIKTzfizwGAr/aWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746234759; c=relaxed/simple;
	bh=dfbwFsUCNatpDIObCeb8tpjWZ9p3Is2m2zwxaW2Isds=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=o2u7KZyy0b8wk46ND1JUZQSQ4YXmzPv1Pzj6WNh8DfKU+RtqUwARuZDL55dJiRr9807LbSB7QsBwSYhp5OR8E3gb0ICsBoYHPWV5YVWCiwfqYOIZ3Jk4Wn2W7uIT11zkXu1paNvcpyNYPfhaPZJMPkZnJmrO3CQRIuGcqWP71kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=gBgSgzZW; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 2 May 2025 21:12:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1746234745;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=QGtUv1KSboYeJiacmqu8UL8Tmt+POSgJ1W5tjoVxpkY=;
	b=gBgSgzZWDR2t6OEoj3h15ZEgfBIC5bH5OC8+yDAAhNTnu959GwQUQ90qJSxkycjUzHGPKS
	LVf4ITyuxLWBNkXJqBi1bWMCb3r3PnKUQnBNlTDUCyr5hWMuaiOthm081e8dui8rABQIXj
	3YzFxn+2ZAMeDtD40QkKAGRljxcR8Zw=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-bcachefs@vger.kernel.org, stable@vger.kernel.org
Subject: [GIT PULL] bcachefs fixes for 6.14.y
Message-ID: <hbrzmt73aol6f2fmqpsdtcevhb2sme6lz2otdn73vqpsmlstzt@egrywwkbtpfm>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Migadu-Flow: FLOW_OUT


The following changes since commit 02a22be3c0003af08df510cba3d79d00c6495b74:

  bcachefs: bch2_ioctl_subvolume_destroy() fixes (2025-04-03 16:13:53 -0400)

are available in the Git repository at:

  git://evilpiepirate.org/bcachefs.git tags/bcachefs-for-6.14-2025-05-02

for you to fetch changes up to 52b17bca7b20663e5df6dbfc24cc2030259b64b6:

  bcachefs: Remove incorrect __counted_by annotation (2025-05-02 21:09:51 -0400)

----------------------------------------------------------------
bcachefs fixes for 6.15

remove incorrect counted_by annotation, fixing FORTIFY_SOURCE crashes
that have been hitting arch users

----------------------------------------------------------------
Alan Huang (1):
      bcachefs: Remove incorrect __counted_by annotation

 fs/bcachefs/xattr_format.h | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

