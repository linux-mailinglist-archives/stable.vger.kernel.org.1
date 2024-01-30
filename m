Return-Path: <stable+bounces-17427-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A59E8428CD
	for <lists+stable@lfdr.de>; Tue, 30 Jan 2024 17:09:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A4D51B22E1A
	for <lists+stable@lfdr.de>; Tue, 30 Jan 2024 16:09:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C98718613F;
	Tue, 30 Jan 2024 16:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b="Dtf/6xrx"
X-Original-To: stable@vger.kernel.org
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B09621272B4
	for <stable@vger.kernel.org>; Tue, 30 Jan 2024 16:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706630943; cv=none; b=IizG9Ti3Q4E2Vn3wz9I1YvKbHR6ooarE1fV5kIgbZp1orHEPN++t3g/xBlxEREtmBHhrKGv77bCXwbpD0sO/VppLTj4e5Vis97f8BOUL8N9bz5IaPTTQM0qhJ9wQxpHkjWOXBRUHn4neTD6x8XuSmSEaMRmi3G754D49xa8SKB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706630943; c=relaxed/simple;
	bh=+QvIc4Z1UoL6JdvZ3iGRTPT0MU1bmVcGBhyue7B95UA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CwmjskyQ3uaRS6/hzuiC3eBCXroAi7zGFgXRDr3MbpqBIzjt/TsGu77FAqIFaqqRAquen036fyBYnsWL47L0wWPixYJrQWFilBRV6A54VV3uhjFMNWYElO6WMV8TP2YvqAI5kOY6P5khtefqAltjZE1OjXJjYVmIiFVDOSjEPT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org; spf=pass smtp.mailfrom=linuxtx.org; dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b=Dtf/6xrx; arc=none smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxtx.org
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-595d24ad466so2766963eaf.0
        for <stable@vger.kernel.org>; Tue, 30 Jan 2024 08:09:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google; t=1706630940; x=1707235740; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n46xbHZiZrs5l9dNaQX2aITyBLQAoYywh4YkaSlR7UI=;
        b=Dtf/6xrxwNSggm0oI4AmK78AUX9JRPYfzPIRJ777oYWvibDxPdSwgtr6CW8g2tIaiO
         +dML2ylPvyN/m5jzo/G7jU3TMNyGUr2HvfAsIF8/CmePeLP9k5RXcgsp0ttqsvIuQihp
         Zy5B7omQ2u/LgbeR8Uz6LCszvpOzV5m5cXfck=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706630940; x=1707235740;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n46xbHZiZrs5l9dNaQX2aITyBLQAoYywh4YkaSlR7UI=;
        b=pTNyZdzeDpuDAUgq4wV15JbGtSIEptx8TnjR+o4ULYNahErino6YFpy5rk4MyZIPVT
         ZZrU73F07K9N28dAXI4XHskpwiFfP9Atd8E4+AQByBiLj1AKwVubeUtQIIMF7pIEgP9P
         gVh3vtP9AEdTmwoZp5vO8xDoPvAgmzgZb+W6JYBCA4CbhfkjRy5OetNAOgPh7oTgdk+6
         24QE9SGlyIdgzSBKHscYXSKXRBRCcAGcV1VLOX6lyBjmia4P+KXiHHL+rincb+w/MH0/
         PisfD7ub/ekivWuGbaWHuFtN8mVzk466rBCqMzQjO6xWXRaIwdm65Kc1o9TREL5MOo45
         OHBQ==
X-Gm-Message-State: AOJu0YxQ2VQXsmfzH9eMsySjfqt2Y+1DKgg1wTGdy//EVTuKJ1/sWD0B
	dxQCu9Bq5Vu0XlkAaz5JP1yCQP5MBAdADsit2+33ZpyMY/7PkZCkw+nU4Uu/nw==
X-Google-Smtp-Source: AGHT+IEu0+K/Oojbff9apgYluaQt3t98C1oqPRPT4DG1CrCd7aseQ7XBLqMgZkkswDUs6Y8mnY6Ovw==
X-Received: by 2002:a4a:e9f7:0:b0:59a:1536:67f5 with SMTP id w23-20020a4ae9f7000000b0059a153667f5mr5936431ooc.7.1706630940670;
        Tue, 30 Jan 2024 08:09:00 -0800 (PST)
Received: from fedora64.linuxtx.org ([99.47.93.78])
        by smtp.gmail.com with ESMTPSA id k2-20020a4ae282000000b00594ee4b4339sm1908393oot.28.2024.01.30.08.08.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 08:09:00 -0800 (PST)
Sender: Justin Forbes <jmforbes@linuxtx.org>
Date: Tue, 30 Jan 2024 10:08:58 -0600
From: Justin Forbes <jforbes@fedoraproject.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	Jani Nikula <jani.nikula@intel.com>,
	Vegard Nossum <vegard.nossum@oracle.com>,
	Jonathan Corbet <corbet@lwn.net>, Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.6 003/331] docs: kernel_feat.py: fix potential command
 injection
Message-ID: <ZbkfGst991YHqJHK@fedora64.linuxtx.org>
References: <20240129170014.969142961@linuxfoundation.org>
 <20240129170015.067909940@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240129170015.067909940@linuxfoundation.org>

On Mon, Jan 29, 2024 at 09:01:07AM -0800, Greg Kroah-Hartman wrote:
> 6.6-stable review patch.  If anyone has any objections, please let me know.
> 
> ------------------
> 
> From: Vegard Nossum <vegard.nossum@oracle.com>
> 
> [ Upstream commit c48a7c44a1d02516309015b6134c9bb982e17008 ]
> 
> The kernel-feat directive passes its argument straight to the shell.
> This is unfortunate and unnecessary.
> 
> Let's always use paths relative to $srctree/Documentation/ and use
> subprocess.check_call() instead of subprocess.Popen(shell=True).
> 
> This also makes the code shorter.
> 
> This is analogous to commit 3231dd586277 ("docs: kernel_abi.py: fix
> command injection") where we did exactly the same thing for
> kernel_abi.py, somehow I completely missed this one.
> 
> Link: https://fosstodon.org/@jani/111676532203641247
> Reported-by: Jani Nikula <jani.nikula@intel.com>
> Signed-off-by: Vegard Nossum <vegard.nossum@oracle.com>
> Cc: stable@vger.kernel.org
> Signed-off-by: Jonathan Corbet <corbet@lwn.net>
> Link: https://lore.kernel.org/r/20240110174758.3680506-1-vegard.nossum@oracle.com
> Signed-off-by: Sasha Levin <sashal@kernel.org>

This patch seems to be missing something. In 6.6.15-rc1 I get a doc
build failure with:

/builddir/build/BUILD/kernel-6.6.14-332-g1ff49073b88b/linux-6.6.15-0.rc1.1ff49073b88b.200.fc39.noarch/Documentation/sphinx/kerneldoc.py:133: SyntaxWarning: invalid escape sequence '\.'
  line_regex = re.compile("^\.\. LINENO ([0-9]+)$")
/builddir/build/BUILD/kernel-6.6.14-332-g1ff49073b88b/linux-6.6.15-0.rc1.1ff49073b88b.200.fc39.noarch/Documentation/sphinx/maintainers_include.py:80: SyntaxWarning: invalid escape sequence '\s'
  pat = '(Documentation/([^\s\?\*]*)\.rst)'
/builddir/build/BUILD/kernel-6.6.14-332-g1ff49073b88b/linux-6.6.15-0.rc1.1ff49073b88b.200.fc39.noarch/Documentation/sphinx/maintainers_include.py:93: SyntaxWarning: invalid escape sequence '\s'
  m = re.search("\s(\S):\s", line)
/builddir/build/BUILD/kernel-6.6.14-332-g1ff49073b88b/linux-6.6.15-0.rc1.1ff49073b88b.200.fc39.noarch/Documentation/sphinx/maintainers_include.py:97: SyntaxWarning: invalid escape sequence '\*'
  m = re.search("\*([^\*]+)\*", line)
/builddir/build/BUILD/kernel-6.6.14-332-g1ff49073b88b/linux-6.6.15-0.rc1.1ff49073b88b.200.fc39.noarch/Documentation/sphinx/maintainers_include.py:115: SyntaxWarning: invalid escape sequence '\s'
  heading = re.sub("\s+", " ", line)
/builddir/build/BUILD/kernel-6.6.14-332-g1ff49073b88b/linux-6.6.15-0.rc1.1ff49073b88b.200.fc39.noarch/Documentation/sphinx/kernel_abi.py:105: SyntaxWarning: invalid escape sequence '\.'
  line_regex = re.compile("^\.\. LINENO (\S+)\#([0-9]+)$")
/builddir/build/BUILD/kernel-6.6.14-332-g1ff49073b88b/linux-6.6.15-0.rc1.1ff49073b88b.200.fc39.noarch/Documentation/sphinx/kernel_feat.py:98: SyntaxWarning: invalid escape sequence '\.'
  line_regex = re.compile("^\.\. FILE (\S+)$")
Sphinx parallel build error:
UnboundLocalError: cannot access local variable 'fname' where it is not associated with a value
make[2]: *** [Documentation/Makefile:102: htmldocs] Error 2
make[1]: *** [/builddir/build/BUILD/kernel-6.6.14-332-g1ff49073b88b/linux-6.6.15-0.rc1.1ff49073b88b.200.fc39.noarch/Makefile:1715: htmldocs] Error 2

Reverting this patch allows docs to build.

Thanks,
Justin

