Return-Path: <stable+bounces-244412-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kAeXIa5Q+2mSZQMAu9opvQ
	(envelope-from <stable+bounces-244412-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 06 May 2026 16:31:10 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 13BAE4DC3A6
	for <lists+stable@lfdr.de>; Wed, 06 May 2026 16:31:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A3A0F3059793
	for <lists+stable@lfdr.de>; Wed,  6 May 2026 14:24:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DC2148032B;
	Wed,  6 May 2026 14:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ju8jHidN"
X-Original-To: stable@vger.kernel.org
Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8DAB47F2C4
	for <stable@vger.kernel.org>; Wed,  6 May 2026 14:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778077471; cv=pass; b=VAgZR0PyXSPfTg85UwjiNwVT+o/lAEI63f6EkILWfe9qfV9gbR9DffVZZITY4l83BYNsggyDWOZh0bhFbI4Y2EJHH2bdoXcejA2Rsl1V6Y1DKUx1L5uq22v+Ez+rZTMKHkP0HikxgwNoF7zKHljjtkkjUhmKRLkobfmhER6VCAY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778077471; c=relaxed/simple;
	bh=5RGPGtjg6gfxQd5la71FcBlakZT2mGW9DnwBFYIWLZk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uDQdLvrLHZV/A6eOkZFkYZhFr+WQe0sS4mDZCxqiJKdJ8yM+OhSwdsP4ZocF6qFtb/DhLyqHs0cNzC/pUqQnSO6f+ORWZ/WMi53Q/3UlnP+2e3I1tXTTEoa+JUCKenZffYApOkDQymtVhd1/N9NeSXVQe8KvmpVBOSThZKavrfw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ju8jHidN; arc=pass smtp.client-ip=74.125.224.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-65c52bb5dd7so3549147d50.2
        for <stable@vger.kernel.org>; Wed, 06 May 2026 07:24:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778077469; cv=none;
        d=google.com; s=arc-20240605;
        b=kANkXFNs8rRrgO8upTofiqZLfiqUmuTedPkk2Qyq/fyydkW2u8GL491k1nG/N4QYAd
         xyLvMQKvQ/9ktBd8dHCokUNhpsWjgDhP32GCLAU+1nkK3WM5F7vioc4F/d2Xr5PKIoMK
         7S7K2yLVbVxGILvN4a2ztY7IcgtbDt38iMz+EFsLDIv/IFBG0wjj68xVKZQ3YCQl/qrC
         Z48Lal75+CoVoRTuR2MjI6qPIoJho3+Kiji9rKvwH7L7fUf5UoONf9y6pxpS0ewlWAla
         rlpn2LoBxDTm7sNtph4UnMowwpmFSFDExeivGjVBtMhz0vLxCw0+GRL/CQQWa2utzPGx
         r67w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=5RGPGtjg6gfxQd5la71FcBlakZT2mGW9DnwBFYIWLZk=;
        fh=Web6gX/8pqejVavX5AkGX5OYOAnvMPeEvQRpPMEAkWE=;
        b=dNQYqxY/FtCwuTYLhta5uuGWj7A6LGj6yNDyd6Qie0sKQ6WPwcGAeGyvsTq/bUeG3i
         ObcJ5MZs4NEkR1rs0uQFh2l8quqK4znFYVKbcQGM6NHhx02P7c3DBhvMVFvW5h9SGKqn
         iH54X6cMqtUw3BTz0oevsp7diYN2izn9x8uzh8apGthvAfVAqubD53w86Uz3QF1pNTXU
         yKS2lXjgn3x6tbOdjP4+OuLOP7GsStgNEyoxDectPcEv12yanvVAYwZMNNGRD/Yn/U36
         W6YJjUYNtgQgoNJbZymiZ3kpqbrc5py2o9BPToi7TwuTFAZFz2QmijoGY5c+05hK4Xcv
         I1xQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778077469; x=1778682269; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5RGPGtjg6gfxQd5la71FcBlakZT2mGW9DnwBFYIWLZk=;
        b=ju8jHidNE6+WcItArQkxY9PbObU3F/6lZ4sERK9KgnURx1qdSdVN7AzNnCyiR6bXIf
         rri033Hi38bUz6uItngbDnoo+rnOV0s2ngJCpP5SjCHMhzaKCLX5cYmmkn7i7ulanHPj
         6QNUdlFVDZ6dUbA8FE8gwHTuulqpPZgDzU+dgkFqaSZT8/0gstm3Qvhiq7FGX1sUfXno
         awWi4IQPNI4XLI3tYqCH8xi760SgieFu1D5eSqSgVaL0QSQK8GOj89jyfbCSJjwF/jp7
         TbEwErHglufgny6HWqO3EBPt4WF+KSTDT3syEWFtFM/CYf8t9ZmLaiUsDY1dGdtiokcZ
         SQ+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778077469; x=1778682269;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5RGPGtjg6gfxQd5la71FcBlakZT2mGW9DnwBFYIWLZk=;
        b=h9Gsh38InQIOy33Z/FmpShOxkQxeUp4lAcnQ/UYn8FCpB8ZfW7JQ3H1QRRJ+67W/Dh
         9k2b1TKn0tlVtA4J4h2nMx/+SUDjzdAQj+e8YA0SiZ+K5cTpz676iDRUdMBHzr2foRvl
         3NZRvAWl7cpx8BA48hV0SWcYnU0WptMwxgCSeUKyvqZvNEM2SqvXjVcXc5ygOUwt8xDj
         VBQ/JBeEw7g2+MaUnCwzjjc9rBpgVwDnFWtyQBUnbzqgAjkvGzkN06eXTXg4WAsbmSaG
         4fNsYywGevDmF9G+ortHXcEnqUi3zVUNP4eqyKlB13Rohf2YgzKOYqEUEEiSuSXgTtv9
         BZTg==
X-Forwarded-Encrypted: i=1; AFNElJ/qVRt11UNQsDt+HvsxvQOHCKP8qlHKjI2qTIPAeywJbwdANoX3Kj0bqfKFnYzb3ThQPF+JEGM=@vger.kernel.org
X-Gm-Message-State: AOJu0YylT8Oi9C6eTLlGkzpbQgxtTM3gbf72OjcqfiPLI/Yd+zN8C6nt
	e+RfSeREeW7+I8Ooxpu6w+zSD7fb6tsL0wkt2mX25ZEh0zyAeiffnoDnGHks2STvRZr099i9w5b
	RJIU4NotvVmBvTIGB66OSg8hC2NHLUAj/jd1XMME+Hg==
X-Gm-Gg: AeBDievxgOzFJrYyRZydD8zAXZUOe9gs2OifPef7CheJO4a7S/CMY8lVwDkeS20mMWj
	+X9b+UXPx8hDUFwHF8Z4Z5xO+1F5LuMoamlBhA9e3uzG77VwVHV2EZ+efLGszKWXCtybjRCzUb4
	dSwW0vUo758d4WhwyvJq4RfXQW3ETitinHRCPOrNbbyXknmLHZjGuf6pAZLVayyf0sfdnHKYz6l
	5yOWJ6ff1TCSmKcjgpjOFYrm40nLOhlJSUcK5CUHd3mhU3hou0xclrDZKFJSb+lBdUnjq2APTPd
	iAY3zSR7YdMf4JqjDUw=
X-Received: by 2002:a05:690e:4844:b0:650:6cb:a720 with SMTP id
 956f58d0204a3-65c7999803bmr2796421d50.39.1778077468595; Wed, 06 May 2026
 07:24:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260506092324.635014-1-lgs201920130244@gmail.com>
 <afsO9TxVuz79FFQ0@raspi> <CANUHTR8PNO-3hfEMCz4Zz_2ERLonE7OyNzPWtAaDtVpNB=YGhw@mail.gmail.com>
In-Reply-To: <CANUHTR8PNO-3hfEMCz4Zz_2ERLonE7OyNzPWtAaDtVpNB=YGhw@mail.gmail.com>
From: Guangshuo Li <lgs201920130244@gmail.com>
Date: Wed, 6 May 2026 22:24:17 +0800
X-Gm-Features: AVHnY4KKgBYwbo8b0KFKRUex7D8jzHNmM2otoNT3MCUewJRlzLyKPSEF6hD8vf0
Message-ID: <CANUHTR_201tMArsXEjuPKW=drk5hfyfneG-sJDqScfxNLLM=Rg@mail.gmail.com>
Subject: Re: [PATCH v5] drm/bridge: imx8qxp-pxl2dpi: avoid ERR_PTR with
 device_node cleanup
To: Liu Ying <victor.liu@nxp.com>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Robert Foss <rfoss@kernel.org>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
	Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, 
	Luca Ceresoli <luca.ceresoli@bootlin.com>, dri-devel@lists.freedesktop.org, 
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 13BAE4DC3A6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-244412-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[22];
	FREEMAIL_CC(0.00)[intel.com,linaro.org,kernel.org,ideasonboard.com,kwiboo.se,gmail.com,linux.intel.com,suse.de,ffwll.ch,nxp.com,pengutronix.de,bootlin.com,lists.freedesktop.org,lists.linux.dev,lists.infradead.org,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lgs201920130244@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid]

Hi Liu,

On Wed, 6 May 2026 at 21:58, Guangshuo Li <lgs201920130244@gmail.com> wrote:
>
> I will also drop the unnecessary local NULL initialization for ep,
> since the helper initializes the output argument to NULL.
>
> I will send a v6.
>
> Best regards,
> Guangshuo

One correction to my previous reply: I will keep the local ep variable
in imx8qxp_pxl2dpi_find_next_bridge() initialized to NULL, since
checkpatch requires pointers with the __free attribute to be
initialized.

Best regards,
Guangshuo

