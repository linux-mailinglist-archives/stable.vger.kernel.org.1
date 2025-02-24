Return-Path: <stable+bounces-118927-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CB1AA42024
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 14:15:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A434166AD8
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 13:14:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85732243369;
	Mon, 24 Feb 2025 13:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="TFeCz0wX"
X-Original-To: stable@vger.kernel.org
Received: from smtpbguseast2.qq.com (smtpbguseast2.qq.com [54.204.34.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAE0F23BCF3;
	Mon, 24 Feb 2025 13:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740402884; cv=none; b=N5vrhnnD40d3iVGAjcWfLHjwvvbm6EosHvKEV6YXHTHHuXcuuFNjaNhO9gx4HQm3mKWcdefBzFJImDFd6kIpcx6e9rpHuMTdYJIj8ebY8feC1KnBpnxNZZOANvCSXqu4o+cM6K57pRMjIQ1uycT6najeC9PWjLOgso/oyEl2KTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740402884; c=relaxed/simple;
	bh=CyJN9JaMODyHdJc8qubxk5o7iU9zvIlTc2ZbhfkECdg=;
	h=From:To:Cc:Subject:Mime-Version:Content-Type:Date:Message-ID:
	 References:In-Reply-To; b=q3k/iRkbq6u9ya0M5vHfbZUD/XtqqnWGLbW4QK8A7XukCu7ngQWqYN0rRrCj0Rww7+69Btr5KoW3GiB9d8/JZC8w0mnbcQSxmAdBJFdLDgdXLxTTS2+L43jwqsjP+idGCaLyawngFpSkLNL/gcdVySChUnxDTZqRGBCKciiOhKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=TFeCz0wX; arc=none smtp.client-ip=54.204.34.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1740402812;
	bh=CyJN9JaMODyHdJc8qubxk5o7iU9zvIlTc2ZbhfkECdg=;
	h=From:To:Subject:Mime-Version:Date:Message-ID;
	b=TFeCz0wX2rOSWZP7ais0R/h/DMJs9yrqJxsEu1HAmaWzpEtcj9AJyXjSf4KG2jhkW
	 sxSmesi/qTG5MA6jVNijpoSd8xaxeXWNsYnZqaxoIU2+l6Zzvutj/yCU8QQDgxHAh7
	 Lwog7MFdhzXwNReNgI2/nYWeP/gz6nzL+yEPCDf8=
X-QQ-GoodBg: 1
X-QQ-SSF: 00400000000000F0
X-QQ-FEAT: D4aqtcRDiqT6iyfUez+DXx4B7ybItHVbSxkDlA8/kMI=
X-QQ-BUSINESS-ORIGIN: 2
X-QQ-Originating-IP: LTKmhXHO+1nYhaZnHpGMJG08yBMWnWJmYXF7R9u8a7s=
X-QQ-STYLE: 
X-QQ-mid: v3sz3a-6t1740402810t4115755
From: "=?utf-8?B?V2VudGFvIEd1YW4=?=" <guanwentao@uniontech.com>
To: "=?utf-8?B?R3JlZyBLSA==?=" <gregkh@linuxfoundation.org>
Cc: "=?utf-8?B?Sm9obiBLZWVwaW5n?=" <jkeeping@inmusicbrands.com>, "=?utf-8?B?SmlyaSBTbGFieQ==?=" <jirislaby@kernel.org>, "=?utf-8?B?RmVycnkgVG90aA==?=" <ftoth@exalondelft.nl>, "=?utf-8?B?SWxwbyBKw6RydmluZW4=?=" <ilpo.jarvinen@linux.intel.com>, "=?utf-8?B?bGludXgta2VybmVs?=" <linux-kernel@vger.kernel.org>, "=?utf-8?B?bGludXgtc2VyaWFs?=" <linux-serial@vger.kernel.org>, "=?utf-8?B?c3RhYmxl?=" <stable@vger.kernel.org>
Subject: Re: [PATCH] serial: 8250_dma: terminate correct DMA in tx_dma_flush()
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: base64
Date: Mon, 24 Feb 2025 21:13:29 +0800
X-Priority: 3
Message-ID: <tencent_013690E01596D03C0362D092@qq.com>
X-QQ-MIME: TCMime 1.0 by Tencent
X-Mailer: QQMail 2.x
X-QQ-Mailer: QQMail 2.x
References: <20250224121831.1429323-1-jkeeping@inmusicbrands.com>
	<tencent_09E5A20410369ED253A21788@qq.com>
	<2025022434-subsiding-esquire-1de2@gregkh>
In-Reply-To: <2025022434-subsiding-esquire-1de2@gregkh>
X-QQ-ReplyHash: 67608264
X-BIZMAIL-ID: 1832330930202671626
X-QQ-SENDSIZE: 520
Received: from qq.com (unknown [127.0.0.1])
	by smtp.qq.com (ESMTP) with SMTP
	id ; Mon, 24 Feb 2025 21:13:31 +0800 (CST)
Feedback-ID: v:uniontech.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: NpoapEztA32CwkNa2GufcN+h19vav4pkwPH0RUvhz5AKMuKltzEqBjic
	SFyiYWWQMPgy5LzwY4bu2wgAOx7r57+7PC9ow7PWlsTf0THf8lUf34errH0hNSX/aAMw3Lc
	Q662wB6NqFbAK7T/VuHp4V3j3qtn6U3kZgpBPW/CJBrP5AwUIAXMPljp5hOh46t0S0rIdiU
	ukg6nDP0gQYYcZcclLQKBtfYalssv4VZNgspeyMy+KNPRNGk4Ejd17oYV/1xfFhYpgwaIiD
	MaiJsYrjrsh6dqhU72LJNuv7yiIvsT88E0/Vf+lqU2EUkXJRz4B/DVUMdQ+i6DV4PAlQgnt
	KteP1R3q02FunWEpgaGul5v+lpS8GPMWHisKt7OiLX+BrdGrnsU3QgkMAnvWA7kilohORrx
	EhLIiLXkFPIwBW/gB8EJ7jmPaw4fsFbrRam5Xo03XWPhckW4g/JaIjv5WdlWBvraceRVxc3
	jA24barTecDIu2ywnk+jcC2dUEjHYj3l4dxEeWVQrvRDpHKhTjipfdiKqALh86xKPBurU1J
	0nGNOLzBUjB9Lg2y2lTVEgMyZhXdu9PikZam/wnEmcMh3LVORtFzjQ4vyfD7J5yB2nlR+dK
	UwtdQpM4E5LX0mZJNXPgFJLmGSHgL0A6HpSb98B53BCK1FUdcaPHahVkZN6dQWR5TVlKT5s
	DrhjpOiA86b1KkLPdjCjqEvDWR45a42ty8DRXwHdPOeT2qyEWJUhsew44rvJxUfj5P0qZAI
	duYWXeTSEvpjooRLxpHBmCHcGnGIgVVzr1uSnRAr8wkRKT8ZncIZfip/NPgksQ+wOoGcO6Z
	q0ZPX4vhVM0SwYlpjEqEG+KhhvaLNcBrw982KVGpj4INgz59Aq+ZbrcVlo4Tc9bHqsFpjOi
	ClVe74w9Az74TWGYhLhaLl8VC5daTeoZigOCNO097N+r6AoqnmVB7iH+C2wyWuSANRNjZJJ
	I3uv1wM4MBCI7iU+SPZwo4mD6/GJWQF4Qy9T5jD2/Qk7c+Nu/hgXx8aFP50MUJOHSjDpW0A
	QjGYOSltYjpxIeko1gGVPwQqAkufcb7A3qJK/Oa7YRojyt74G8Jz8f4NcD4FPkW+9MsiobH
	i5XLqVQQi0K
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
X-QQ-RECHKSPAM: 0

SGVsbG8gR3JlZywNClNvcnJ5IGZvciBteSBIVE1MIGZvcm1hdCBwYXN0Lg0KSXQgaXMgbWVh
bnMgdGhhdCAnRml4ZXMgeHh4eHh4JyB0YWcgcG9pbnQgY29tbWl0IHdpbGwgYXV0byBiZSBi
YWNrcG9ydCB0byB0aG9zZSBzdGFibGUgdHJlZSB3aXRoDQp4eHh4eHggY29tbWl0IHdpdGhv
dXQgY2Mgc3RhYmxlLCBjb3JyZWN0ID8NCg0KQlJzDQpXZW50YW8gR3Vhbg==


