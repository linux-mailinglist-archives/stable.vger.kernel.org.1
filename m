Return-Path: <stable+bounces-217713-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eMSYNJUcnGkZ/wMAu9opvQ
	(envelope-from <stable+bounces-217713-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Feb 2026 10:23:33 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 52B68173D60
	for <lists+stable@lfdr.de>; Mon, 23 Feb 2026 10:23:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F153F30045B9
	for <lists+stable@lfdr.de>; Mon, 23 Feb 2026 09:17:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA1CE34E74E;
	Mon, 23 Feb 2026 09:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nYVdD+vV"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92D2828E0
	for <stable@vger.kernel.org>; Mon, 23 Feb 2026 09:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771838274; cv=none; b=TvIfv9fizmNY3oT3q+H2f2Iu8cGtzjV683oL65ue3F3ao08VHFG4WVKQO1n66qEClZPmv09XEu++AA92r0Xx4B+opi4g9oKiyTIDHZ5nAgW8m6Le13Ird6sJtPox5LVO3ipTmmwa2knPZuWex/ho6NhIt88Ucy9sjuByL4Sd+/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771838274; c=relaxed/simple;
	bh=4PioQTE1/pn/cSvWasq9vsu4M69jf5y8EpRedJOKuQM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HRhApxltp2YenSad8ynkIaeuO5OzbQHOCOBs+4dHSja7YcPCkjjzuDLqs83A60hueFeH3wpItjKpUOzhbZmutBH0mvwUg+rYq2gOoTeYjj2Xh9mMogP+vtQEY/aywGgWswk3w1vs45umpnMLknvtRt7nWZJyi82E4H4j4J2Szoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nYVdD+vV; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-82361bcbd8fso2033686b3a.0
        for <stable@vger.kernel.org>; Mon, 23 Feb 2026 01:17:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771838273; x=1772443073; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vsAzAZV+vDh9kg6mWOSA63o6/YiuK/GmIL99VmqCAg8=;
        b=nYVdD+vVJtvQ5Zpq7TUYNiy1J7DlojfNhE5/z169rvyAVE7LJpDVEsY0PFwTlRQ0H+
         mWhY3q442sHNntSG00C2nwCb6ep86Ip4c2BFpf4+MNzK8488LJeLCqoB+rkVuCBkdWYX
         4lW85RcX2ZXQacQwFbAmHSX7Ax6m4XLbqEvCr+hfy9qGDAIQbX/dX9GxXR25LcIE1P+Q
         ybWamskq2BKAEE6WjmQbPdsphBPQs+NwGk4EnMvigej7A37MkNqxp90lmyqJiPv8OBPp
         i4XpZzjYLWzCWjfQ5XZlmizeaJqwpRJdxbe7AytDrdXRLzqXt8wUCClN5a+V2T4sm6uY
         jFOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771838273; x=1772443073;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vsAzAZV+vDh9kg6mWOSA63o6/YiuK/GmIL99VmqCAg8=;
        b=dKZMqu7ksLc61utT+Qmk9i8By5myJz2+LwRsrHhJGTkWtuwYmfcbXe2EfgjihB5Gl6
         vmGJbKWB3fDj9CnWun9c7PAXQHmiNGgZa5VVpBBL4SqDFsLSBQ8j9SCk6+Dw4j+3K7JW
         bA5PRGxNcN6no83xgDJz3w4llrJScQ72Vl6XuE6PXw+fZughbhKo5JA4GdRlb8OeNT78
         mUZHMuWNHREj9nkfGv8ERQS9DfJv9cXv2X2Xt93WUbhy4qd4Ll3sDgSHaseTp+93vU0Q
         edSxgU4fLh/JsKKl8NBShSLf/6ExokvS9buDzvA+u/NzXE8B0ThRtANIxrmy69COaY66
         L6pw==
X-Forwarded-Encrypted: i=1; AJvYcCUc6yRR2gh27MC+1ywtgbz3sBdRsBo3CXg3xbsBCspKb168rtKB2zD1egljaQUxbMKz1RjMhL8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPeb5rMPvj5DHnhYA2QbiYwirJkODQ9AdkhB/DNfBukgghsTpb
	2SVRxwQchzmv8tlmaXoZFJutBms7MqMerxwYHg+/NKEkZ/79LYYV78+8
X-Gm-Gg: AZuq6aJfdSbhsLTz5hQjsNrr54MOvQHxwxQGqLU47K5/pG5rpM4peQKvom09sk03MNo
	pJr/011byteoPBJ4KlQ2I+16UIQ/sQXL/CCGM2bBhp/GhP2gAwMQsRcVNCBs9vTri2EH3jrMdLR
	neMknVyPp8tAC1+Jk/fKb5ljlvrjthamiI3v2cVEsElh/TsVkYAb1ByGHvY0XFjNJhY9C/yD3jV
	7MAI3vdkY5AtCdSeABH4py+9S6QvT7l+tuistyV5DxwQ0XAmYnB92NYaV4Y8rt+OLlAovsLDgo+
	GHqAX7Kr0ZnZE7cGUfL6KC1NDnmI4DWuj7kHjenNGWgDBaPYjE1prUn7xOsIpD4inQmwACpG/Uh
	i4UGitLmZS5fKabgkChF48AVpwnOmOGQHCZGWpPu33kD8Si95pnSsn9BdxaOu0clxOy/Wzz9vfu
	fSND4L/r7TYzx4P9dowy62k3XR1KemPrZuHJ/plQSd
X-Received: by 2002:a05:6a00:2389:b0:81f:3f03:6832 with SMTP id d2e1a72fcca58-826daa62853mr6926447b3a.44.1771838272905;
        Mon, 23 Feb 2026 01:17:52 -0800 (PST)
Received: from e50dbb8e4021 ([115.245.213.202])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-826dd689474sm6353180b3a.15.2026.02.23.01.17.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 01:17:52 -0800 (PST)
From: Sanjaikumar V S <sanjaikumarvs@gmail.com>
To: mwalle@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-mtd@lists.infradead.org,
	miquel.raynal@bootlin.com,
	pratyush@kernel.org,
	richard@nod.at,
	sanjaikumar.vs@dicortech.com,
	sanjaikumarvs@gmail.com,
	stable@vger.kernel.org,
	tudor.ambarus@linaro.org,
	vigneshr@ti.com
Subject: Re: [PATCH v2 1/2] mtd: spi-nor: sst: Fix write enable before AAI sequence 
Date: Mon, 23 Feb 2026 09:17:33 +0000
Message-ID: <20260223091733.47-1-sanjaikumarvs@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <DGM6ZPOT1WCR.157JI0LW4W3E8@kernel.org>
References: <DGM6ZPOT1WCR.157JI0LW4W3E8@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	SUBJECT_ENDS_SPACES(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_FROM(0.00)[bounces-217713-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.infradead.org,bootlin.com,kernel.org,nod.at,dicortech.com,gmail.com,linaro.org,ti.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sanjaikumarvs@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[11];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 52B68173D60
X-Rspamd-Action: no action

Hi Michael,

Thank you for the review.

> Raises concern about writes ending at odd offsets potentially having the same issue

The odd end address case (trailing byte) is already handled in the existing code at lines 243-255:

/* Write out trailing byte if it exists. */
if (actual != len) {
    ret = spi_nor_write_enable(nor);
    ...
    ret = sst_nor_write_data(nor, to, 1, buf + actual);
}

So write_enable is already called before writing the trailing byte. My patch only addresses the odd start case where BP clears WEL before the AAI sequence begins.

> Suggests simplifying the conditional logic by removing the length check

The condition `if (actual < len - 1)` avoids an unnecessary write_enable when len == 1 (single byte write at odd address, no AAI follows). But if you prefer unconditional write_enable for simplicity, I can change it in v3.

> Notes the patch lacks runtime testing

I don't have the hardware setup to test odd-address writes at the moment. The fix is based on code analysis. I have tested patch 2/2 (dirmap fallback) on hardware.

Please let me know if you'd like me to send a v3 with the simplified unconditional write_enable.

Thanks,
Sanjaikumar

