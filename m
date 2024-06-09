Return-Path: <stable+bounces-50051-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 58138901671
	for <lists+stable@lfdr.de>; Sun,  9 Jun 2024 17:12:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E09161F211F6
	for <lists+stable@lfdr.de>; Sun,  9 Jun 2024 15:12:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB95142ABB;
	Sun,  9 Jun 2024 15:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=rwarsow@gmx.de header.b="I+cfQfCq"
X-Original-To: stable@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 394ED1CD24;
	Sun,  9 Jun 2024 15:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717945933; cv=none; b=DCw4RNZ2jk6V61aG2xEWcj0R4mQtV74pynfBIm8bbkcIPVXAMaRrXQhQRTdRB2csLDz5CXqRGZMC78XYLfKXNscw/H1QZAy+eAQHDWrnBzO47BcAGlocDaGUTpytdeCaDr/6DKkCxun/bh6dketpxNwJESM237jMy0G1mxNKBNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717945933; c=relaxed/simple;
	bh=dmMdDLN3YgL1qMEqV22WwccWKGPvTDnUyQtKaq9KA84=;
	h=Message-ID:Date:MIME-Version:From:To:Cc:Subject:Content-Type; b=uhe1OU0PMzZZqL9XDyJ/FiyVANqw1UQs2oAkDkAnXhA5WPj0+7a/4x+y+MLqEwGwVbKYUzB8ZUB6kAOcJ7dkk2WHPVq7O6+zBB86hNDqkBBIZfk1qqXKupxoME4kcU5fvWTAfwIxWihOdBJqtDBJO2UcUw9hUNFCARvIr4eKlVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=rwarsow@gmx.de header.b=I+cfQfCq; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1717945928; x=1718550728; i=rwarsow@gmx.de;
	bh=dmMdDLN3YgL1qMEqV22WwccWKGPvTDnUyQtKaq9KA84=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:From:To:Cc:
	 Subject:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=I+cfQfCqtRLMi5CgJGd6iQbYkST+bFly9thcdjgZmQX3N+277PcsEcRpY8EnoCdx
	 jjf/WMaZX3okPAytW7YgZpZDGq2eIXEFCDSlP8WiA6w+OHXlYDoppy5bfaEomAHX+
	 xvqEF3a4aUWzbnv51TvEw/L5Y+q7l5rgv9gd7hsW84sV8+3pdsS7gyLj4QqEUn5w8
	 wCjFQRPhuAisUPoA2Yr3yT5Cd7ppGaS6zgRYBxLlO/IQvL+1OGztcg4BegzJhZElT
	 cGdM+iMX8/Va+wokuLPsjifw+H4xpliRb2whHHdzANbUBctI5mmDgh2gQQ96dyld3
	 CEMFq78uXUFsq+kIPQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.100.20] ([46.142.33.133]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MGz1f-1sCFch2glv-00Fev3; Sun, 09
 Jun 2024 17:12:08 +0200
Message-ID: <b7604cf9-fbe8-4726-ada9-deb7ea8ebe9c@gmx.de>
Date: Sun, 9 Jun 2024 17:12:08 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Ronald Warsow <rwarsow@gmx.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Content-Language: de-DE, en-US
Subject: Re: [PATCH 6.9 000/368] 6.9.4-rc2 review
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:NLK5OvngU/P0glFEN8x6RXXBU82EZeBk/BW0q3d0PwzFaOQD9WY
 eC93zD09w7FxaM0wKx0WweuP9b0EAnCDrGMOPV9x3T8jdaybKAoVHiprTnAK/gmRy1Tb6Lg
 Qyf+BThh477q6SlG3EUP2qS8PqzBOZ+iw63Zo9Hk8rLU5yBbfwCrajHJ8q2kA+qQznZIC+V
 iAKjOFlVdqERgXQTcl7TA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:C5CGfagr8XY=;DjN9IMCY2daBKMCWlcqoqTmr4AV
 E+NZIZrZrsI2ZvotN26692jieKnmNCKYJfN7tNtDY9z1t+G2Yh2A1H/y3K2xR0k2eahbuc+0/
 wZhLvnbymsc/HVq/+zpFDVX+oS+qS92cvnF6fZcKh5yK7VPA8QvokNH5QgtfET8+IOxCFt1b7
 a2I8mvcrjJ5IDoKIeuME3d5S3VZtsQUpoq2p9WC4wGrMqOcEYw1ZXwZhHLaPd5ZRD7dKE2+Ui
 eVyIdfNPCjvOQG2SdzKYhR5/RpAQg2548foGNSYllsBMPpiaSRj1b7NY3tXEkj7EdXjrFzH54
 NRQtGB6I9Gsykt7GTLMRn89YBaFo4Gr/91Sh18VawN8DZsOKV/iUukpCishe1G2fJQwAZN/Ta
 C+TRZXUPYgIuUAegBCumoSIk9h9RcvE5toES5Nt54gQ0aG1nL8SpgE1jvRu87xvh9+L0uy9FM
 ylei5e6cEzSl0X5wED3BofChy6PPhzmw5DILUvIb9W10cWK3bPW5Ji8vnJfCRjQ73Rj5ztvoS
 VhYxyzVYn3z9X3PX7a7NR2raxgJstk9mJrDoAGPK1hbpP9Mh9/T84fdLZNhwA77/zIdaPNMIF
 3pdis4E8vdXROoXbetYJaVJbO3sJ6JxoPc9bsv2FWpoiuLTSFgtfLRSUz8TrQSb0681qj7Lkm
 LciyC5SzErexwaYjHYJyXFEJI++m8kyKxOFsc3gKBMzM1kOr/MHKrox8oTy3xXmeUOxypTFos
 W+PMOjOyUgdZDKLTsJ+LnzH0femSOaiqIjSxmxutfPzk5oYrZI3sKAQF9uVu79h7iuXeCKxs/
 ig+QRza1U/qr0jp0xOVmA6fN8nBgAtcUEZlO1/r8PhPZE=

Hi Greg

*no* regressions here on x86_64 (RKL, Intel 11th Gen. CPU)

Thanks

Tested-by: Ronald Warsow <rwarsow@gmx.de>


