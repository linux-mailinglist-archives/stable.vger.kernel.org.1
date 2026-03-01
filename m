Return-Path: <stable+bounces-222444-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IEFGDS8SpGlcWQUAu9opvQ
	(envelope-from <stable+bounces-222444-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 11:17:19 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A6BB1CF1A8
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 11:17:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D46DB300681F
	for <lists+stable@lfdr.de>; Sun,  1 Mar 2026 10:17:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C481430BBC;
	Sun,  1 Mar 2026 10:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kGew8jgO"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 077E1175A8F
	for <stable@vger.kernel.org>; Sun,  1 Mar 2026 10:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772360219; cv=pass; b=lF/396sXO6Evz4X3/EK9dXaG5TnEq+f2x4yHTMAYmL1EUfJfOkvXzV/r9T6w9CprkuttJa15d5SHYYXtWfuEOtXWQyJB7dkFzN8RJsFULs3PhbdL5fsp+07y49IHJpOixJvoWJ+B02SO9deS+3sV1NUiigEBBWyJIQQ656JVxQ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772360219; c=relaxed/simple;
	bh=MjAMUUuhY7RKH0+if5r7fta5EcdkO3xQ/b6WYVQ2OjI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E3niSXGocezeLleEeR+rs6j9G763+IAF2p7IftLgFuf5Q0VpeHd9FOt9lLUtOX50xPBBAUjZfiDSb/3tJJjcYLUWjcxdymN7Sugj6dGKmyZPplMRW9O6pMG+BOCMOBVtO581yImqxxoAlqWkKtGd9Hgw+/3X62dvxG/eb19fJnA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kGew8jgO; arc=pass smtp.client-ip=74.125.82.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-2be084d8166so11359eec.2
        for <stable@vger.kernel.org>; Sun, 01 Mar 2026 02:16:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772360217; cv=none;
        d=google.com; s=arc-20240605;
        b=NJQZMX08/y0FlQA8lrR+LXeuztHi9sbr+Clnxny3ruEF7ecqT+8tufc16QBTC/BAaN
         U+l+epOHpuYibSlWzeIs/xkhcHlluot8WMjLrcblvXjnBS/aa+ueBDfMxX+pePn8Zi9+
         ftvaBqO9LSk0VZGT/AjxS162rInd1l2imfQPSyQxD40qJBgDpoiE7pqp6iico9KO1NhG
         Z9KJ6/LixWuDMdoxnj6lMBOSmtB4zrjwoP/gv2q9Il5uhYyLzKPv6kysfYAXfZw6TD8u
         NmCiSop11/xO8kqocNTVT9oiw8ymFNKbp0ia6J1r7ONyil9H5S/CT4d3Z/zdIrBH7hb7
         awzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=MjAMUUuhY7RKH0+if5r7fta5EcdkO3xQ/b6WYVQ2OjI=;
        fh=6SlAK/s1LDjYOpJGfmZa0f6MYkX0DKJLke/nL7xIdlg=;
        b=CCyNBoe7buqYiVen4qFjiWt/foLArldYWMfysV2uguJ+5QLizaQSp9hfB5xsJIhjBr
         fZjwznN+DyOGThPQKsN3SuRZNN184n6c0cb7oJJNivpAOVv1KprUVH947WPig42heDCw
         y88sre93Nm0JNMd8GsNFMUrhHSNrADDD7cYWAyBRmQPY6wF0RU/ss2Sk9BYM6RngtboH
         mKUpuxYAavIzCBBn+ki0cnOI9BvgFjwlo0iCuMbF8R7qCQptszQyTpm3QcNctnp5lrFd
         bojdq49IBpau3QgTSpOI6bHxjcsMgJjrjs4lsVr1/Wh6A4hueAHNfpZWBrOYCSIcQHbS
         bmBw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772360217; x=1772965017; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MjAMUUuhY7RKH0+if5r7fta5EcdkO3xQ/b6WYVQ2OjI=;
        b=kGew8jgO2Agl1tCE7nx734dogMtxHkLI2TGtIGSmtwwvRtsE/SeKeU5HWPtbw05HRE
         ty2pxsrr4GkqAZItE0g0khRLvrcfB4+5G0K+n6VRni3+VELwDtziQVOmkiWbk1C3xUgL
         INNMmIxO8uwqvzfrrJIAuXO2Xmb+o2xjhzIwcTmx0GnCnY3HTXlVZW43fXUDARUXIksw
         MztECgAel1PU1HAWWuFoY5FqIg+U74hZiCa10ZaHDpVSLPCPvdYevOi+8z86RCQIwGqj
         uZp57uAYQpQxNRTG35tepqtlnMf/d7LxAEQQVNGUi/AFe0nUq9uJwhisvfq5CxX1zPbV
         iBkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772360217; x=1772965017;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MjAMUUuhY7RKH0+if5r7fta5EcdkO3xQ/b6WYVQ2OjI=;
        b=rF7QoZDMlmRGF3PVhZRo7kcNzO/vBwnisO7l5BxWqv5SLzTTHTjr1WoUw/7FKAb/2g
         oZ/HVf8i3G9fQpoa1fzYD25T0YZM3YCTCuVy7hWqm3A0AdlebjfTygHAgT2o53A2IfrJ
         /rZagmCvW8qWPf/+eiEKwIay56N9BQmq3hlh4nBYBQaIZ3Yad3Pz+vcTkFO9/OmRg9LO
         mKvxK+Bki7mjrtcj1Duos7eIusVZZEOOQ6ngBqymPwj5893J7xGwcDeBjxcuhxNuA84k
         Y9cUH+7AKxYQ+ve6cP8b3mq82U+5fisAleIIveAWHD0HWcM3b5MufF1bqv0c7sm2uXaS
         by8w==
X-Gm-Message-State: AOJu0YwMop5AgTzHFxYw6ZBpXac+AwxTwJYzb+U2iHaSRoh2l28WSf3c
	MMRYaT4j+qJvwRQ3SldfkZ6boS/tWS6T8otWl0s+9XtTtHr8aLtyzq3QXw3tcrgjV0aktHsLLSu
	2aQin/qM8XhZtrk7qb+G+OA8ffFTi3gY=
X-Gm-Gg: ATEYQzzOcu4UmfB65+oNYIVDtloItXugkFU508FIUJFL0XJ3tsTrGDt/7VSHuv1/CtW
	P+6qIdQgZIi3mRsO7517CDKESREGE4lYe+3iaIu6GfFJw7ymK2KNARO1eyv8G9drGBhjn8X6zmN
	QCQkzSgKfe1r4NCc1M6uLPHau5rrM/01IH+VTuXH+XT4vegKauzdWPDF2Eh8fXXBLa6Bync5qZ+
	2DTw8ikxWNG4qLm4Agjy+XVlpjyctoLOzWpQO3qqh+UIW0+jio3HbWqqQslqVScuG+q7CLqiQJX
	lOe0bTKIsgIKKLlAy5jKHFzTMWfzcteZAEE1OOgtujGe6D6g3whnMPkg+PDUqxYJV+9CMwYdwYz
	UJKtvaMkU3hporhZFACN0v7za0N9Z
X-Received: by 2002:a05:7300:640b:b0:2bd:d17c:b0aa with SMTP id
 5a478bee46e88-2bde1d4e9d8mr1793959eec.6.1772360217139; Sun, 01 Mar 2026
 02:16:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260301013933.1700585-1-sashal@kernel.org>
In-Reply-To: <20260301013933.1700585-1-sashal@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sun, 1 Mar 2026 11:16:43 +0100
X-Gm-Features: AaiRm51-EeHPvScbrf6Wx5oLREbMPPYfNZwFV9k3-GP3PI172bbzw1BlkT1Q_nQ
Message-ID: <CANiq72m0yD=mt7CKvrp-EHcC8TmY4AEdY4J04F1mJM7foNyb2Q@mail.gmail.com>
Subject: Re: FAILED: Patch "rust: pin-init: replace clippy `expect` with
 `allow`" failed to apply to 6.6-stable tree
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, lossin@kernel.org, Miguel Ojeda <ojeda@kernel.org>, 
	rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-222444-lists,stable=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miguelojedasandonis@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 4A6BB1CF1A8
X-Rspamd-Action: no action

On Sun, Mar 1, 2026 at 2:39=E2=80=AFAM Sasha Levin <sashal@kernel.org> wrot=
e:
>
> The patch below does not apply to the 6.6-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.

The Rust version is pinned in 6.6.y, so this is fine:

> Cc: stable@vger.kernel.org # Needed in 6.18.y and later.

Cheers,
Miguel

