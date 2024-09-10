Return-Path: <stable+bounces-75769-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92133974629
	for <lists+stable@lfdr.de>; Wed, 11 Sep 2024 00:54:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EDC1FB252A9
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 22:54:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E26C31AC423;
	Tue, 10 Sep 2024 22:54:26 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail.aaazen.com (99-33-87-210.lightspeed.sntcca.sbcglobal.net [99.33.87.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 196531ABEC9;
	Tue, 10 Sep 2024 22:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.33.87.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726008866; cv=none; b=FQ/b9rHZGyB/iobDm4bH1MU9sC7suPdDUA3ROLltFodhZSSjklWFfj55RGYlPS1sTJ1yxkGb3nwGqyHtjSoVR+yXqj7GX1WNroXTKQWfT8S7Ul+eSTBRgcm6+7WwL8kBKcofG7tVg0mYSNevd+P0lavAgtQk49RFtAQKIUUydGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726008866; c=relaxed/simple;
	bh=YKwQ2QZRSedpGBWSLjXvn1kFcTQuxACS8cfrcjV8FcE=;
	h=Date:From:To:cc:Subject:Message-ID:MIME-Version:Content-Type; b=lohEcsBHgcput3f9KBGRpHFmHQvFHY/1ZKrXR6FSUm/MRUs/pWn4zz56TcTPyQOC87hF58rOF/66BTzy235HaPnf+rxyGgfGDoksukkLEQif3sd37TCZqog+FqSlNXJQYLJ5LgaBqtbK9yWXww0085BHExKfFUBp7JcFDZqVJh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=aaazen.com; spf=pass smtp.mailfrom=aaazen.com; arc=none smtp.client-ip=99.33.87.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=aaazen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aaazen.com
Received: from localhost (localhost [127.0.0.1])
	by thursday.test (OpenSMTPD) with ESMTP id 4a9a167e;
	Tue, 10 Sep 2024 15:54:18 -0700 (PDT)
Date: Tue, 10 Sep 2024 15:54:18 -0700 (PDT)
From: Richard Narron <richard@aaazen.com>
X-X-Sender: richard@thursday.test
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
cc: Linux stable <stable@vger.kernel.org>, 
    Linus Torvalds <torvalds@linux-foundation.org>, 
    Linux kernel <linux-kernel@vger.kernel.org>, 
    Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Subject: [PATCH 5.15 000/214] 5.15.167-rc1 review
Message-ID: <4a5321bd-b1f-1832-f0c-cea8694dc5aa@aaazen.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

Slackware 15.0 64-bit compiles and runs fine.
Slackware 15.0 32-bit fails to build and gives the "out of memory" error:

cc1: out of memory allocating 180705472 bytes after a total of 284454912
bytes
...
make[4]: *** [scripts/Makefile.build:289:
drivers/staging/media/atomisp/pci/isp/kernels/ynr/ynr_1.0/ia_css_ynr.ho
st.o] Error 1

Patching it with help from Lorenzo Stoakes allows the build to
run:
https://lore.kernel.org/lkml/5882b96e-1287-4390-8174-3316d39038ef@lucifer.local/

And then 32-bit runs fine too.

Richard Narron

