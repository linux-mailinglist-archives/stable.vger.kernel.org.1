Return-Path: <stable+bounces-189267-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A26CC08DCD
	for <lists+stable@lfdr.de>; Sat, 25 Oct 2025 10:13:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 21C8D4E0F53
	for <lists+stable@lfdr.de>; Sat, 25 Oct 2025 08:13:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACE28252292;
	Sat, 25 Oct 2025 08:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hOsplahc"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C21E51FF1B5
	for <stable@vger.kernel.org>; Sat, 25 Oct 2025 08:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761380013; cv=none; b=p4tpqTUNyBlB70+GVF+BOmbeOYt5F77bC1dlKmAu6zeKRynPX2lAb0+JJoOAc8lVyD7sT5ApyHKpfIsqn4qtT3XKp/IkoKaVBoHrdeu5bRmNJ3Ixs3o4wSwVTQHhNsaiNKOxrFAN9MFo4XhnNjRE2RRyO0hKiqsLluWvANGf6kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761380013; c=relaxed/simple;
	bh=wJwEoBt7y8yp0JIWrhZ6cO3RBa+f4zIHYZgGUeVG2N0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=i+WBUmd1TAk6ddr3uFehq47/o0Zuu1WAyGM8mJNZZaa3CFbw5X5nGay7kXPEceZd9W3NAyvy8XAD9PrgQt4qux9Bymxlu3+jk/QnADwWQXGuBuOHWvF4NDvJFwV1XNkmgetEP+Roe4A/Yyw9qGST8dxcXlxNCA85bS5z50QnbCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hOsplahc; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b6d5b756284so564111866b.1
        for <stable@vger.kernel.org>; Sat, 25 Oct 2025 01:13:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761380010; x=1761984810; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=wJwEoBt7y8yp0JIWrhZ6cO3RBa+f4zIHYZgGUeVG2N0=;
        b=hOsplahc1aYG9gXnkJEQTg3r2P464O/f/RdywVVrX3tDctH6dgrZG65FdolkrHHCSi
         50kgppPfA8YNml0Yk4mQRr13Ylp/5hTIE9r4YBXY5nc3GovzXI3kC38h3AwYWNQRFlAY
         psWkND1pbDOxMOVYHNtK+rS+Qyv3tXnBGXVNKPUyKxTxyGwgrcayfDKXLly6b8/ssQ0B
         q5hJriUmXn2VagMkOTTnWXlXtPGe9hy6tOrcIZS2nLLRkLaIZvZCmTcXq68UW9iQ7dsx
         Sls14EBj4cGQyulPFlyur1xzgs/KHLoy7ZpcrDUOXnKEwK5sjBuatnwHIYwLi0OjKYjT
         EFuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761380010; x=1761984810;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wJwEoBt7y8yp0JIWrhZ6cO3RBa+f4zIHYZgGUeVG2N0=;
        b=YQNDkJ9WwcBkNmcF94yAhnoHIF2wB4Z/jyByPVOSKINfT3VjRfIkWb03qEXjsqAnXy
         eK5Wl81osAnHg9+v0Tl6zTdm7pIY1FG1cxX/vuLEx1U0BZ0Jui+jgfCxCahf2lpBfu7g
         uqzWTWb8ry/EvWzq9Lqn2ukG1JE+HtEuWbEAvMZbJqFBpaSx9JhPP82XrpfSm+0IFCLf
         QJ3YY2HeXxemwklHxLuyUDHlR1bg8KwoMLzeemYvKr74smiGKEaH7OGMBKofwIGkuYzT
         TA9Ich3orhBpLUyJhJHucuXv8R0/9ZEOAtUPREnh1Iiu7C8lwB1zFv+XKeRg9FH/3pUm
         HXCw==
X-Gm-Message-State: AOJu0Yx/F/4RDNKosJt0Sm+WY8XX19DEmZmUPRFqBnTVOyjPLjtU5eoL
	G2hHAh3V5wyrFVjPRjFwp5X/RXtp1NEA8RbKO4x6K53KlV0Id9iaN69FINSBNxhZ
X-Gm-Gg: ASbGncupRW7LplrFlI1wU9K8j8qP1hdCpL0uIkzd7jh8sCWzF1QLyljss7Jv8xYrypj
	rqmUScgVwCmUB/O+ucn7FX1r+qXEffiuQocKOfXGq9dDxE+FEXVg66yuH+VThi2xOIz/dsy6NC8
	xaIN22heCfWZIacrnpKQO/vZyflvm+a0yc22PYzqthOTlYPx+Km6Uj2JXDu37uokRG9OzB6o734
	w1B82u+fjnneSFhFeHgvj0VwZ2GnK0mNDTzCqtdgbsOkbwfmhq+Ws71bvP4GxWfrTyXOFvnWBoc
	umfARSNJ0sA7h0Fng2Vv+bo9PdB1yfthS4gPVlc17/wIdr8UhEBU49lZFtyNI2jUolV1Cr3X8Ww
	1ISgribZiVtDXl72N0SsTspGcYdXNBjgZLNSu4y3UBz3FOnmJOZcsaJHl/SD8GPEWMhwt8RP4Qw
	eKHN8/I403PGW1qZzyldGJO4Ze+1E1trJEUIoXAdFIKG9M
X-Google-Smtp-Source: AGHT+IFBFdJTUcEvIPmHvc6pWt9ouAnPWItwU6w3xhjwhZg1QBaXzwCAOgOdGX85b4xcUkuOig92Vg==
X-Received: by 2002:a17:907:70d:b0:b42:9840:eac5 with SMTP id a640c23a62f3a-b647482e03cmr3829488866b.61.1761380010007;
        Sat, 25 Oct 2025 01:13:30 -0700 (PDT)
Received: from eldamar.lan (c-82-192-244-13.customer.ggaweb.ch. [82.192.244.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b6d853f3851sm139090066b.48.2025.10.25.01.13.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Oct 2025 01:13:29 -0700 (PDT)
Sender: Salvatore Bonaccorso <salvatore.bonaccorso@gmail.com>
Received: by eldamar.lan (Postfix, from userid 1000)
	id 8EB8BBE2EE7; Sat, 25 Oct 2025 10:13:28 +0200 (CEST)
Date: Sat, 25 Oct 2025 10:13:28 +0200
From: Salvatore Bonaccorso <carnil@debian.org>
To: stable <stable@vger.kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	Guido Berhoerster <guido+debian@berhoerster.name>
Subject: Please apply commit d88a8bb8bbbe ("Bluetooth: btintel: Add DSBR
 support for BlazarIW, BlazarU and GaP") to 6.12.y
Message-ID: <aPyGqPklZSrC7FJ2@eldamar.lan>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi

Guido Berhoerster asked in Debian (https://bugs.debian.org/1118660) to
consider adding support for bluetooth device of BlazarIW, BlazarU and
Gale Peak2 cores, which landed in 6.13-rc1, via d88a8bb8bbbe
("Bluetooth: btintel: Add DSBR support for BlazarIW, BlazarU and
GaP").

While it is not exactly a bugfix, as things were not working
beforehand as well, this type of hardware might be very common during
the lifecycle of users for 6.12.y stable series.

Can you consider picking the commit for 6.12.y?

Regards,
Salvatore

