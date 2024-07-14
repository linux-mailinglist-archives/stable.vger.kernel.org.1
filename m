Return-Path: <stable+bounces-59243-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C2599309CE
	for <lists+stable@lfdr.de>; Sun, 14 Jul 2024 13:48:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3179281B14
	for <lists+stable@lfdr.de>; Sun, 14 Jul 2024 11:48:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14ED411CAB;
	Sun, 14 Jul 2024 11:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=m3y3r.de header.i=@m3y3r.de header.b="yiUwUQT3"
X-Original-To: stable@vger.kernel.org
Received: from www17.your-server.de (www17.your-server.de [213.133.104.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68628B656
	for <stable@vger.kernel.org>; Sun, 14 Jul 2024 11:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720957695; cv=none; b=cVH5TSPVVjHPJtok5d0IQf6ABKaNROzliR8PI4xEXc9CE/C46BL73TMhcK+XVq9CFI8Ji23QG0DH6l3w8CVTmYQaOQap/ys4o6RZ7xF/9sF5/a2QA9YTFHKrP7cLJ7FWm45iKWLSK0hZCi2E1zCiA5FmpruNiNOSM7Ad0wP9BPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720957695; c=relaxed/simple;
	bh=4iXsrwG0Jc+yquer4CjBRG1CDYMIEiQDIIdL3SzzykA=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=PdX9KdLI4bZf3zg31FIQCLUsYFMlNTTMjo6k7TbsZMwFnysTgC5puKW5YhowYhUovAPf3YgR5F+fnsbys+CTU242J2uf97la+1D7vfr+sxkHbOF8tsE6UsCs8Gngsd3Y9ot4DvxWrYt50yihPLtEFkQAjwTl5+dLMlrB8601RYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=m3y3r.de; spf=pass smtp.mailfrom=m3y3r.de; dkim=pass (2048-bit key) header.d=m3y3r.de header.i=@m3y3r.de header.b=yiUwUQT3; arc=none smtp.client-ip=213.133.104.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=m3y3r.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=m3y3r.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=m3y3r.de;
	s=default2402; h=Content-Type:MIME-Version:Message-ID:Subject:To:From:Date:
	Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References; bh=WBpfBwAx/e7rZP3UMXEhS46oFqQQGu1Qx6kcHxqyglI=; b=yi
	UwUQT3muUuFTTMPr13Npf0QbzQ14TsaEku2zY6pp863thMLndrJjGhu4psuzoL4yQkGag5ycHeW3M
	19Abl0Qmb8YU2RpdYyUq2aNefzIjkKp5OYxIdjip5KpUqIof5jBxuc+SZA7MTR7ZWmzA1CB2FleTU
	tFevZhstij7AO4UE4Lyb4oxnOjMnv9y/G+Trrt/Scn+OdtKbfMa4+Hk94UxCtbSPOsXBzq2pJDVf+
	PmH+nLjb0XCoowuJfdwR4ogr6Pp3NtUR7/Fw3hE8FBhjuozr3t2g/eAmTBdmxq+4JR4lLAx0f6OGx
	ISB9dGlbyXBzw+pZ2mN93EkzExPoZ/tg==;
Received: from sslproxy04.your-server.de ([78.46.152.42])
	by www17.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <thomas@m3y3r.de>)
	id 1sSxQo-0007tg-M4
	for stable@vger.kernel.org; Sun, 14 Jul 2024 13:30:18 +0200
Received: from [2a00:6020:509f:6000:41e7:900f:edc:2880] (helo=localhost.localdomain)
	by sslproxy04.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <thomas@m3y3r.de>)
	id 1sSxQo-000EOH-1S
	for stable@vger.kernel.org;
	Sun, 14 Jul 2024 13:30:18 +0200
Date: Sun, 14 Jul 2024 13:30:16 +0200
From: Thomas Meyer <thomas@m3y3r.de>
To: stable@vger.kernel.org
Subject: 5.15.x: randomize_layout_plugin.c: 'last_stmt' was not declared in
 this scope?
Message-ID: <ZpO2yOXdylWmyaaj@localhost.localdomain>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Authenticated-Sender: thomas@m3y3r.de
X-Virus-Scanned: Clear (ClamAV 0.103.10/27336/Sun Jul 14 10:33:25 2024)

Good day,

I wanted to upgrade my kernel to the latest 5.15.162 but it seems to fail with
this error message after upgrading to fedora 40, any ideas what could be the
problem?

$ make
  HOSTCXX scripts/gcc-plugins/randomize_layout_plugin.so
scripts/gcc-plugins/randomize_layout_plugin.c: In function 'bool dominated_by_is_err(const_tree, basic_block)':
scripts/gcc-plugins/randomize_layout_plugin.c:693:20: error: 'last_stmt' was not declared in this scope; did you mean 'call_stmt'?
  693 |         dom_stmt = last_stmt(dom);
      |                    ^~~~~~~~~
      |                    call_stmt
make[2]: *** [scripts/gcc-plugins/Makefile:48: scripts/gcc-plugins/randomize_layout_plugin.so] Error 1
make[1]: *** [scripts/Makefile.build:552: scripts/gcc-plugins] Error 2
make: *** [Makefile:1246: scripts] Error 2

Maybe a problem with gcc 14?

My current kernel was compiled with gcc 13:
[    0.000000] [      T0] Linux version 5.15.160 (thomas2@localhost.localdomain) (gcc (GCC) 13.3.1 20240522 (Red Hat 13.3.1-1), GNU ld version 2.40-14.fc39) #15 PREEMPT Sat Jun 1 16:54:27 CEST 2024

$ gcc --version
gcc (GCC) 14.1.1 20240522 (Red Hat 14.1.1-4)

any help appreciated.

with kind regards
thomas

PS: please cc my as I'm not subscribed to the list.


