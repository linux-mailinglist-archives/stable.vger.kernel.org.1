Return-Path: <stable+bounces-139697-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D245FAA94EF
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 15:56:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E4DE3BCBF3
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 13:55:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0EF324C092;
	Mon,  5 May 2025 13:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="siGy6ILg"
X-Original-To: stable@vger.kernel.org
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F83E1FDD
	for <stable@vger.kernel.org>; Mon,  5 May 2025 13:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746453359; cv=none; b=YPBCpax2iPdBOxs6zwLP38M9D0XMzmcdpJSMTOK65G2Gr6tKKWfvQ1i2A24hnVxLQavz1yuV4NHEDEapOXv5duc4IGwmcbEfSAvi0+D2SuZW9QDQ9uVEql05Z7+FHGFsl2fprRBXPmqZ2m/+svx/V2l2spo/vu1DLLQx2hJ24dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746453359; c=relaxed/simple;
	bh=37kT7C4c/c/BVxK3pOrkTB887jVDgrtzhYOcjpxu3ps=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=m/48okck084l1FiYwFZvpZ4ImPhJ8u3YrVqKIhC1F+QmRm6K1bIsxDesDbcMu6QiN1EJq4uLXCS8LUYgOp0SNeQR+oDiKbYAw8iFlSL1rBq0O7iMO9Guar4g0fUOjC2PZRl1FerEJc0EPEVjAFZ6Gjma86827QmrunUyfEEHMQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=siGy6ILg; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 5 May 2025 09:55:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1746453353;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=XtRLUheaE6ilPFXAGDwguzy1lOFBtvV+bN2uo0xvyms=;
	b=siGy6ILgK/Y0W4UUvexjxYR/kIdn1N25HrWcgAk00XQDKUvg91eedSNsAdL1mgbqqHwobc
	QGoGnNA+GmCW62uVTDQRPWS4PV/LrCSS++Vap747rtFXcuaw5/R9BbEy8sZ0GaZfM2OqYG
	IJ4DcySGDcnuyah83S6wdvI86xI3NhE=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-bcachefs@vger.kernel.org, stable@vger.kernel.org
Subject: [GIT PULL] bcachefs fixes for 6.12.y
Message-ID: <3bje6r3eacjrffmvayjgoaxrz3rowplfvq73vlm5oq3cx4vdow@b7mr6c6nbzwv>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Migadu-Flow: FLOW_OUT

The following changes since commit 1a7a2300e0dd8b4a73bcd3777a2947fe42a16bef:

  bcachefs: bch2_ioctl_subvolume_destroy() fixes (2025-03-31 13:16:15 -0400)

are available in the Git repository at:

  git://evilpiepirate.org/bcachefs.git tags/bcachefs-for-6.12-2025-05-5

for you to fetch changes up to 3f105630c0b2e53a93713c2328e3426081f961c1:

  bcachefs: Remove incorrect __counted_by annotation (2025-05-05 09:41:26 -0400)

----------------------------------------------------------------
bcachefs fixes for 6.12

remove incorrect counted_by annotation, fixing FORTIFY_SOURCE crashes
that have been hitting arch users

----------------------------------------------------------------
Alan Huang (1):
      bcachefs: Remove incorrect __counted_by annotation

 fs/bcachefs/xattr_format.h | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

