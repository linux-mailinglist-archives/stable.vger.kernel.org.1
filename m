Return-Path: <stable+bounces-152542-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F24DAD6A39
	for <lists+stable@lfdr.de>; Thu, 12 Jun 2025 10:16:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B63D3A694E
	for <lists+stable@lfdr.de>; Thu, 12 Jun 2025 08:16:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABF16221578;
	Thu, 12 Jun 2025 08:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MS4f1oVm"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB234220F51
	for <stable@vger.kernel.org>; Thu, 12 Jun 2025 08:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749716125; cv=none; b=pF/noKelrEbFMst3IFqD0Zev8B4QH4O4vQ+Xw7zCgeWCI6W60WsS2NaF3lW9Bmg4WFsnMVO+jk96F8JducsNn0U3HR9J+OqeU9zxZk1v9uPB2MnHGnT3wlrFqI7uL51FX12YB5a1BLS1XWDCOPXhhgL4K5wjsbHDtVC809Kq/Mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749716125; c=relaxed/simple;
	bh=lBKwX+O4KVOXGA24/5v8NW34dV1xfHAYop5k9y6dES4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GVcsp/gKDuvzbnf3oRchqQ5FByK7obm6dDfUaEI0vy3ORJOXSbwADMFfxwolKaL7ufpeTSJmNoSCfti+CW0YdPc46dezDi12bwIfz0kxIGPIpL/XswOqG1ODazln4rdvvtZmHZK1SFUbIp9Y92zljUXbPotnk+SViMPpRc1perA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MS4f1oVm; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3a376ba6f08so393116f8f.1
        for <stable@vger.kernel.org>; Thu, 12 Jun 2025 01:15:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749716122; x=1750320922; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=OiHYNuRdA2z6F+JZ9jDJ84+PdVEDalxdRBrZuRPl1B8=;
        b=MS4f1oVmnaLDsA9JRrLO9LVbZed0h6oXrbM1MvV04hXWH+jmweExJt0yj/bhA7pskU
         1AqgSIX1cw4MtlhFGKkXCiQNicFqZk5/cmeMQMj6tdC2akWcdudwiceUFT9sXbWifOHr
         dtP0Afvr5cOf+gQwSY61WG8/QQxAk/+UhQRP8tduz1DLJZUhWgkr6CDkoD9FzRUCZLyZ
         yXbhKqIlJUHUZOdsTcxKjvfgD5HCnYKe4MvElRqNLxoiMvPqO5D4RMpWdL3Ai71eKgh6
         Ez+SvdK5Kc6EUVsV8+42B84nKomfAXs39/qOMexQmvWRARKUqacZgSG88mQcGS8vc/8V
         hfsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749716122; x=1750320922;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OiHYNuRdA2z6F+JZ9jDJ84+PdVEDalxdRBrZuRPl1B8=;
        b=wTgYPmP/3hASzfXZbTj8EQq1ogygFuBtYAhcMZmO/WEqJlLXnuaIbyMrU7T2vGP5wq
         wJTeiJRwwUZo5qGXEPGm5vGGjVMiAp2R0lholseKD+rAnJJvOGrB5PrIsjWTCKWVXiQ+
         VAtbK+zrYfS+vHWzcLtnEDRYPLok3Qp5RPZndT6/PaXcobTRdh/7JdiHzpm+fLKjeZyf
         nYXoSabQtrYz0C/SBJ2COFdJ7HNMRSQTiGznuFu+cQn05umI0iC8L7O5+VKXOImUkjwF
         FaExSeZALlV3u1ApraTEjwPRm0Dv3q43OP8Ph/EMAf0Zv2mSvEcNc6R5z83InCpLDIfD
         y4zQ==
X-Forwarded-Encrypted: i=1; AJvYcCVPZ4IgDW703G6+Bx8rGdGESIvOjn6tuKRPHNsY5VeIqOKHAiy9qMpSW5vv+ls373QzVhFm4DY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfdeN7DHTxJvI7WHpHcw4veGUbY04ArHtMXmltgl7PBtMMOf2Q
	Afl2k9DXSezPTWcERIhkb7vYKzmK9uEA80OOGQRQPAsUI9bCnkC0w1W5
X-Gm-Gg: ASbGnctRYkNpZYVlDCiGR2w5px/NbEdhrhvVwwvYWOSdQ45SJk6QCp54MgYNR/PpTHX
	buHXyfbIc5F/qFJk6OqjmOxUpgKAzdCdChdB6iMiSX1lk50YOdhiH82jpe8MmVpUELh3fAnMMb4
	6b23x8eKUZVkXX6fKaJ/vhtl8Rblp0eF2nf19+ZhwRWuTMlPESycYChUYNg9Vm2cm8LvMBwsINS
	fp/BaLaZumfxvZdpbNtuQhycD0kieoYGWnL6nlXFnTPEbtaXQqc9MxGXAh8Be/l1hmpwzDWSVhB
	BtHUvAV1l/+KD6bknDfiNNE8VVUsUXUx2Vvtr08QSXY9fDWNWDWPKMKW8rvLiIW6jbWKeK2Lwvj
	GezGw7BW6BGf7AT0=
X-Google-Smtp-Source: AGHT+IH5/CAlJBqc1ga1W7RgZTMPvmkXjPxsssJzU8PYoPDM/J1IVq8a5BwS6dwgsq26AWjjqagJfA==
X-Received: by 2002:a05:6000:220f:b0:3a4:eef9:818a with SMTP id ffacd0b85a97d-3a561349f32mr1597702f8f.27.1749716121746;
        Thu, 12 Jun 2025 01:15:21 -0700 (PDT)
Received: from localhost (v2202307203666234413.quicksrv.de. [45.83.104.137])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3a561b65ab2sm1257570f8f.96.2025.06.12.01.15.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jun 2025 01:15:21 -0700 (PDT)
Date: Thu, 12 Jun 2025 11:15:09 +0300
From: Ahmed Salem <x0rw3ll@gmail.com>
To: Jiri Slaby <jirislaby@kernel.org>
Cc: Collin Funk <collin.funk1@gmail.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org, patches@lists.linux.dev, 
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH 6.15 05/34] ACPICA: Apply ACPI_NONSTRING in more places
Message-ID: <3nobung2ragvykho52thb2pouxgjatmh5cjtc2vh3aro72lkk4@bp45zihoq6v5>
References: <87ecvpcypw.fsf@gmail.com>
 <5c210121-c9b8-4458-b1ad-0da24732ac72@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5c210121-c9b8-4458-b1ad-0da24732ac72@kernel.org>

Hi all,

On 25/06/12 09:23AM, Jiri Slaby wrote:
> On 12. 06. 25, 7:31, Collin Funk wrote:
> > Hi Greg,
> > 
> > Sorry for the exta mail. Accidently put CC emails in the subject...
> > 
> > > --- a/tools/power/acpi/tools/acpidump/apfiles.c
> > > +++ b/tools/power/acpi/tools/acpidump/apfiles.c
> > > @@ -103,7 +103,7 @@ int ap_open_output_file(char *pathname)
> > >   int ap_write_to_binary_file(struct acpi_table_header *table, u32 instance)
> > >   {
> > > -	char filename[ACPI_NAMESEG_SIZE + 16];
> > > +	char filename[ACPI_NAMESEG_SIZE + 16] ACPI_NONSTRING;
> > >   	char instance_str[16];
> > >   	ACPI_FILE file;
> > >   	acpi_size actual;
> > 
> > This one seems incorrect, as I was alerted to by the following warning:
> > 
> >      apfiles.c: In function ‘ap_write_to_binary_file’:
> >      apfiles.c:137:9: warning: ‘__builtin_strlen’ argument 1 declared attribute ‘nonstring’ [-Wstringop-overread]
> >        137 |         strcat(filename, FILE_SUFFIX_BINARY_TABLE);
> >            |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >      apfiles.c:106:14: note: argument ‘filename’ declared here
> >        106 |         char filename[ACPI_NAMESEG_SIZE + 16] ACPI_NONSTRING;
> >            |              ^~~~~~~~
> > 

Thank you so much, Collin, for shedding light on this issue!

This is now reverted in upstream ACPICA commit a6ee09c ("acpidump: drop
ACPI_NONSTRING attribute from FileName") [1], and pending merge.

> > The 'strcat' function is only well defined on NUL-terminated
> > strings. Also, there is a line of code:
> > 
> >      filename[ACPI_NAMESEG_SIZE] = 0;
> > 
> > That also makes me think it is a string.
> 
> Ugh, indeed.
> 
> FTR this is about 70662db73d54 ("ACPICA: Apply ACPI_NONSTRING in more
> places").
> 
> To me neither the above, nor struct acpi_db_execute_walk's:
>   char name_seg[ACPI_NAMESEG_SIZE + 1] ACPI_NONSTRING;
> is correct in the commit.
> 
> This is broken in upstream/-next too.
> 
> thanks,
> -- 
> js
> suse labs

Thank you so much, Jiri, for the attention to the other issue.

The above issue is now reverted in upstream ACPICA commit 4623b33
("Debugger: drop ACPI_NONSTRING attribute from NameSeg") [2], and pending
merge.

Rafael, the upstream PR [3] is ready. My apologies to
everyone, and thank you so much for the review and efforts!

Link: https://github.com/acpica/acpica/pull/1029/commits/a6ee09c [1]
Link: https://github.com/acpica/acpica/pull/1029/commits/4623b33 [2]
Link: https://github.com/acpica/acpica/pull/1029 [3]

--
Best regards,
Ahmed Salem

