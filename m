Return-Path: <stable+bounces-139642-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 388BDAA8EE8
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 11:07:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 324A41888B75
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 09:07:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDACD1F2BB5;
	Mon,  5 May 2025 09:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="f9ZXIkMn"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 935FA19E819;
	Mon,  5 May 2025 09:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746436022; cv=none; b=Rwa+tZ5RCFtkUdHK00Y+ULIPdiIgu3OipHHx0XGb+Hd0QETfgQvN5GompO7DYqTz9ybkGSnXBNDMuPnOLOjxpKpfXcESuKDbQ9abBL6z8LHBTmk08TUuu40mjh1koe4Eq4ouggUkcxsGIWyPvsUDmSpkE0AlmvzyHzbgcrsJucg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746436022; c=relaxed/simple;
	bh=ql/0/6yGoPPbdUE5UEYGjN9ugYmI9D6yVj2uoYYYkHc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RV7KfriNVD1h6Nlp/w/UjrdhGDcOKJLoj0xdKG2YsvtUVDWk05Mq6iw1EfJTuF0DZaaP1cWouG4K7oEgwJocvVUejYnl0iDjBVgTFzaeV2bS1VN8Ogs90uBmlAGqk+nVBlYCqmpYEwLLy5a8hx3KOW59++W++SFZ+JwG1iXoono=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=f9ZXIkMn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89195C4CEE4;
	Mon,  5 May 2025 09:07:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1746436022;
	bh=ql/0/6yGoPPbdUE5UEYGjN9ugYmI9D6yVj2uoYYYkHc=;
	h=From:To:Cc:Subject:Date:From;
	b=f9ZXIkMn0vtOP+M79q8RY+Ld0pzUZUKiQVELRoao4S0Rx9FkWgKA7R1T/Eef9djzq
	 +iSwnI7Qm0/4xAgNWT7EJHdhW/jn76SGdfhMRZW0ErbxyxZGZULxay19gkBnOmDTXC
	 e0Ox2zEO7nEtELtmCggD+x+mmtE0ZjP17/LHiHJQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.1.137
Date: Mon,  5 May 2025 11:06:57 +0200
Message-ID: <2025050528-kissable-viral-627b@gregkh>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.1.137 kernel.

This release fixes a problem building the Loongarch target in the
6.1.136 release.  If you do not have build problems with the 6.1.136
release, there is no need for you to update to this release.

The updated 6.1.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.1.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                        |    2 +-
 arch/loongarch/mm/hugetlbpage.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

Greg Kroah-Hartman (1):
      Linux 6.1.137

Huacai Chen (1):
      LoongArch: Fix build error due to backport


