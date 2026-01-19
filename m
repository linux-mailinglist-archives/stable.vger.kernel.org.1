Return-Path: <stable+bounces-210299-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CB3DD3A3F5
	for <lists+stable@lfdr.de>; Mon, 19 Jan 2026 11:01:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6A1AC30317A5
	for <lists+stable@lfdr.de>; Mon, 19 Jan 2026 10:00:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3FB8357728;
	Mon, 19 Jan 2026 10:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="c5lRzYTS"
X-Original-To: stable@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92A053570C1;
	Mon, 19 Jan 2026 10:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768816841; cv=none; b=qvzaxSObzfH6hb/7jGM4znz5wXSB7kRb7Ts6El9ofjHGHR2aLS8/tK3eQKVZcSIZfZJviJgoZVZLoSIfs0m87Z4CJG2atZj4VgA9gwNcBpJOeNIo85doYm68p8ILfURUNVXrEGUVACclNx3BTHzWnNen1CGVTrfyBzrRoT9umkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768816841; c=relaxed/simple;
	bh=rg1wqdyrE+ErQL7lxrfVd7J/BU2JGGpQKMIOGFEZhsY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Cy+fNi48VACbx3RV4trt39MUyLdBl3VVM76Vom+HaGs9mXGFmY2W5h/egDKGqEPmotCDW12Mp1A4Z1wK/zm1svV83j6gkPektfX6a53UAAM2RwhnfGhBPAnBW9/XceynCfeJXQ1r/vfU5hgI+yzebEUMksVPXBBMzBDeG6iwF+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=c5lRzYTS; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1768816836; x=1769421636; i=markus.elfring@web.de;
	bh=uSPrSjXDkEs4ba/d5D83v7doFkckOY/XFSqib1yGazM=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=c5lRzYTSeHzXX+Rz6cqfWMlMPuwmFJhz5wefpTN/GsyRYeaL7bErexYVAcf/+MKV
	 pcnrcCy9T2Heizha07WlHbOSOSoSPhs1y+uNrWc3AA3K82PgdeIN6qeA3L5u8dVHO
	 eomg8WWLHZ58c9mnWfWIMgLqqmYAi75aKjDv2yqE9RlywLFzjUoDrFMYl8rNFuUbI
	 b1pJtIFCPV1JqWA4Kq7oNHNbjKziJRnemjM1o9Ct9QAYiMZtnXNZrSLX1Aau9S7AH
	 OKlzKlXluVe/Mad6k5HJ6XkUyoa1NVh7igr2MWG/52y82jcJwUK9tbALdnxbjMjke
	 wPLjr7YPP+fcb2Hdng==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.178]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MFaui-1vZaji1KjG-00H6Hq; Mon, 19
 Jan 2026 11:00:36 +0100
Message-ID: <2f70230a-2bb2-405c-9a44-793964da630f@web.de>
Date: Mon, 19 Jan 2026 11:00:35 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] fs/ntfs3: Fix memory and resource leak in
 indx_find_sort
To: Jiasheng Jiang <jiashengjiangcool@gmail.com>, ntfs3@lists.linux.dev
Cc: stable@vger.kernel.org, kernel-janitors@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>,
 Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
References: <17914287-640d-4500-b519-5f3d3aed2878@web.de>
 <20260118185736.41529-1-jiashengjiangcool@gmail.com>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20260118185736.41529-1-jiashengjiangcool@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:jPM5XMq+Far808kKh3ZKLl1GwgjWL9MmJjiy8B7UcJTEvTk7gm/
 qc+zQlQRK9nv+RG/p8u1vLd1mZbImMy0Ew9ZQKLsVUzCtDPPLB+koFv2k6/PyyRha6MvMSP
 nm6SCDlo0dSIjtU47hVUAYj2F9BeuhNxqNUFUP9ASSJ6HTYvtArz5Qnp0lHSyr6cLWR0jev
 skaiZLYDMWz6uLy3XBwHw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:yBvViGVhqjo=;+7cO1+alQfH3TS87VZacV1PGbXl
 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
 UzbBIM3tUh+sAb/sW+CFxZzU0Ui2T

=E2=80=A6

> This patch replaces the incorrect kfree(n) calls =E2=80=A6

Thanks for another contribution.

* Under which circumstances would you take the usage of imperative mood
  better into account for an improved change description?
  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/=
Documentation/process/submitting-patches.rst?h=3Dv6.19-rc5#n94

* Can it be helpful to append parentheses to function names
  (also in the summary phrase)?


Regards,
Markus

