Return-Path: <stable+bounces-208443-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 93E1CD24A78
	for <lists+stable@lfdr.de>; Thu, 15 Jan 2026 14:03:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BFC01302571E
	for <lists+stable@lfdr.de>; Thu, 15 Jan 2026 13:03:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4EA139E18D;
	Thu, 15 Jan 2026 13:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="JwxF9rvq"
X-Original-To: stable@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E146354AEC;
	Thu, 15 Jan 2026 13:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768482228; cv=none; b=PS5LXoi/PoSIo0N8QH0cdvoUoB4yLb64u4zNBQCXXyh2f6kdtN0Hpj08EMn9s8ACwGJr/UC7UWxOyQYJS3/WwybXkig6r2h7zQ7h6HRURvHSYU711IK+dTaG41rbkxhBgi/Cvlgh3U++L5bB6+ZN/coHl/WRrAwEV/thuieiX00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768482228; c=relaxed/simple;
	bh=WlDu/kL1qmIdf/AYZ8utNV5Icv6uFtizvReTaXdHMec=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=i2QSlnzJqM4L/9JMdqdUhUi7p9dcnHdIcwFvt0fI1MnHg0brQgjTyq47XNsSdGYgB9X4BiZjNpBm+LJrSv7NofQRm5nmzWIqdJan1LJcBeWet/jg4l5jzZJ86JtdTS5oqDvLDFmu6Zb6T2q6ZW3mhWpxmRdQE8+6SkMvFDdmgMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=JwxF9rvq; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1768482216; x=1769087016; i=markus.elfring@web.de;
	bh=WlDu/kL1qmIdf/AYZ8utNV5Icv6uFtizvReTaXdHMec=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=JwxF9rvqn0jSg1/sUIdfo2/kJ04HmhTDPNrCiUW5GbgAERu8pkXfd3v2TceATiTr
	 r1xIY2dPypeAcozPBekVqv1+JTSWoouNKZ0uU3A28CT3YGRY2JDFrXYa/uYIr3e74
	 CzT3yUQr2HIJObKFs+DYUJCXPcvNvuf22ObdKyn2ajjUa9ozjzKbN3lNtqax6xa+M
	 1Cz/JTXQTFFsUs0Db4NCsM98dtH6Ughnpaw6G7rkosnq9CIJ5Yme+l+cZ0ZfIYwes
	 ZUh9sjrgFE56PcD7HMZxgLW/71aJu63S01Z/SZJJ8JyCpHZ8XbqI6cOzlgud9Nn4F
	 yXfXLu+NdaMUygMHLQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.191]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MjgSv-1w5EMe3YPj-00eiic; Thu, 15
 Jan 2026 14:03:35 +0100
Message-ID: <bf800455-6f93-4695-a36d-e6bfcb9a7e34@web.de>
Date: Thu, 15 Jan 2026 14:03:34 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>, linux-clk@vger.kernel.org,
 Brian Masney <bmasney@redhat.com>,
 Gabriel Fernandez <gabriel.fernandez@st.com>,
 Michael Turquette <mturquette@baylibre.com>, Pankaj Dev <pankaj.dev@st.com>,
 Stephen Boyd <sboyd@kernel.org>
Cc: stable@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 Mike Turquette <mturquette@linaro.org>
References: <20260115045524.640427-1-lihaoxiang@isrc.iscas.ac.cn>
Subject: Re: [PATCH] clk: st: clkgen-pll: Fix a memory leak in
 clkgen_odf_register()
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20260115045524.640427-1-lihaoxiang@isrc.iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:wbSSppVOlzr1nMS0rjlbXEpiEq+Fq/k4Azpc63cQ+PRlLQ5I1jF
 YD0xhXvyMaXE+I46KdhwD+AxARLBGNFxNO5igYwvUy83NNkf4x0x1PO3iGAJvCUlmi7NqB5
 IXm6Ml7FUTgSeohz3rAWmVsDEyVNStp6Xyp/Pr/eCxt5MyjaLzLEraWg8l/Q0dKH+C5THnw
 LsUsIrXmJ1O7db6N/BbrQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:CXHYAnd1jmU=;8COkaR6/h+L7oeAGNKsM0Y3NSMU
 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

> If clk_register_composite() fails, call kfree() to release
> div and gate.

You may put such information also into a single text line.
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?h=v6.19-rc5#n659

How do you think about to avoid a bit of duplicate source code here?
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/coding-style.rst?h=v6.19-rc5#n526

Regards,
Markus

