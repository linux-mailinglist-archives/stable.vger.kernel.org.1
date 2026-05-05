Return-Path: <stable+bounces-244009-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mLnaKACm+WnR+QIAu9opvQ
	(envelope-from <stable+bounces-244009-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 10:10:40 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 02B6F4C875D
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 10:10:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2FC4330107EB
	for <lists+stable@lfdr.de>; Tue,  5 May 2026 08:10:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D27D3A3E69;
	Tue,  5 May 2026 08:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="rbi2S0zs"
X-Original-To: stable@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8412D175A60
	for <stable@vger.kernel.org>; Tue,  5 May 2026 08:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777968620; cv=none; b=rmnjTxDf9Q0Y5KzUjYdrxahdFJmFGpoJLwT4GBBexI4x2uOywVB3Iw1JsHoWlRtnYWv1zKedgluf26QI4NsQxDFEyQ2Ff4GzAWkpVflc3LIGuuoMc6kxKl5EKJJPyguVLv5hTjW9J7f+xoybN7OwrTBGHZXqIOQuVvsCuSXTXWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777968620; c=relaxed/simple;
	bh=2ajGsto+fkULMbVHALYVrcuruVtiBBl0r54Ob0QDCTQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cy0jJP8AiN1TTSJwjgWifVfzWp+xyHqOTGenZfs5x+vMJj0G7NM0+jAyT2xFnALwkR56qJNAS89HfFI/c5VS9z9HryNOjuOgxZZNSUtSg7Y5Xks5zWsg++Pe6Txlzd/Wd0xAQ0l/8LAuHcP5gLxAhExbYe3+t8OMBH/8cJl9MuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=rbi2S0zs; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 8BE9D1A3523;
	Tue,  5 May 2026 08:10:11 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 5A8175FD9D;
	Tue,  5 May 2026 08:10:11 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 25FC211AD249A;
	Tue,  5 May 2026 10:10:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1777968610; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=wqojrbNmyZDtYjYTfDSv+NteblAz01LppSlPWqNNyS4=;
	b=rbi2S0zs00YEewZbf9Qul0BnoxDxqZDYJfeVDTSeREai7hgjWz+xCHL0KlY9fCGbDFVHgF
	GBp7wXS6xkK9FovJ4aqUwvev9RFjvQ1ES3MFZXJMWiLK2ZSLNacSPBatnezCzIg7wPJ68n
	axtaipDDOY8XETclJFiiBH6f8Tam0kY7OJLHMSfVsB+g7T1ue0ofN6fvvNTqq/JwU+p5kj
	1buQRC21xCZz9kCM4d39Ql4dxygd0r3gQzUKP2o1iY79TPYMBB+XlxoTV6c8bTMOCr4gS3
	1avcfIaLz/TI2CEecbITwm3wDqGMEAMeDSDY/KVrc6rJIs6JGzW7R0XFmfs0iA==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Arseniy Krasnov <avkrasnov@rulkc.org>
Cc: Richard Weinberger <richard@nod.at>,  Vignesh Raghavendra
 <vigneshr@ti.com>,  Frieder Schrempf <frieder.schrempf@kontron.de>,  Boris
 Brezillon <bbrezillon@kernel.org>,  linux-mtd@lists.infradead.org,
  linux-kernel@vger.kernel.org,  rulkc@linuxtesting.org,
  oxffffaa@gmail.com,  stable@vger.kernel.org
Subject: Re: [PATCH v1] mtd: rawnand: fix condition in 'nand_select_target()'
In-Reply-To: <57b0cc2a-6d62-405c-bfa5-68d1c46dbad9@rulkc.org> (Arseniy
	Krasnov's message of "Tue, 5 May 2026 10:59:16 +0300")
References: <20260504221012.1310605-1-avkrasnov@rulkc.org>
	<87mryeqoqs.fsf@bootlin.com>
	<57b0cc2a-6d62-405c-bfa5-68d1c46dbad9@rulkc.org>
User-Agent: mu4e 1.12.7; emacs 30.2
Date: Tue, 05 May 2026 10:10:06 +0200
Message-ID: <87h5omqntt.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Queue-Id: 02B6F4C875D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[nod.at,ti.com,kontron.de,kernel.org,lists.infradead.org,vger.kernel.org,linuxtesting.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-244009-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DKIM_TRACE(0.00)[bootlin.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miquel.raynal@bootlin.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,rulkc.org:email,bootlin.com:dkim,bootlin.com:mid]

On 05/05/2026 at 10:59:16 +03, Arseniy Krasnov <avkrasnov@rulkc.org> wrote:

> 05.05.2026 10:50, Miquel Raynal wrote:
>> Hi,
>>
>> On 05/05/2026 at 01:10:12 +03, Arseniy Krasnov <avkrasnov@rulkc.org> wro=
te:
>>
>> Two important typos in the commit log :-)
>>
>>> 'cs' here must in range [0:nanddev_ntargets).
>>                 be                           [
>
>
> Hi, sorry, You mean?
>
>
> 'cs' here must be in range [0:nanddev_ntargets].=C2=A0

I meant [0:nanddev_ntargets[ which is the mathematical way, IIRC, to
indicate that the last value is out of scope/excluded.

[0:nanddev_ntargets] means that nanddev_ntargets is included in the
scope of values and here since you are explicitly showing that it is
not, it feels wrong to use that convention.

Thanks,
Miqu=C3=A8l

