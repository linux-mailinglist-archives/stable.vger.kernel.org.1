Return-Path: <stable+bounces-245300-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MFO3GvASAmrangEAu9opvQ
	(envelope-from <stable+bounces-245300-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 19:33:36 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id B297E5138BD
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 19:33:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2ABDB308A6D8
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 17:01:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13EA3441022;
	Mon, 11 May 2026 17:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OhEKgON8"
X-Original-To: stable@vger.kernel.org
Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9227243E486
	for <stable@vger.kernel.org>; Mon, 11 May 2026 17:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778518882; cv=pass; b=UQIQ95coffhOIIYKmm+w+4bVHlsNZOG/G9GWEdRqnXCdQJ++0qY99UYb6WIBxtb2tbqh59JSkooNFRvWnsD3MBtbaYd3pvlKcbyYO4VcAk+Lo4hpISqmkwq1kjr7yxcLoDDrrafpf3B7iZrw1yb0o2oJpWDGko6imJZqgCKai4k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778518882; c=relaxed/simple;
	bh=sX76fFKdIdHWcvUPNAk6ORnTk1gk3SV4Auw12s3ZtLg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jSmWw4ldCHj1QIGMGuDb/VvHfh/goY6JFpUZBlHAqPHA3WQufMT6lA+EWUuiO/y32A+hRfV8aG6JsX0iJSQjtXJoOtEV1zSvaeJzzz02VKPYgoRU+gO7oY+KqKainA4oGXS3qhUcUmgFKmxRS+VnsLe2ryCHf8eqcibvMWo2xEA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OhEKgON8; arc=pass smtp.client-ip=74.125.224.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-65c24be9e4bso4792202d50.1
        for <stable@vger.kernel.org>; Mon, 11 May 2026 10:01:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778518880; cv=none;
        d=google.com; s=arc-20240605;
        b=e0SYUKsQO+Etc5elz64EsRHIIL835yjcmYdbfRTdJgNJ4wxCZ8TO+27DroUw4WolBM
         EF8JKnSPXwhcWugytKy4uvDjuJnPczYZH5/DJAKALnhO+Xi3IhDkWFC2BbO/p6W5fcAy
         PDixM12bNnHVQVTk0cI7UJAhreGSj6N8tjQr3AXUfXZtq1HwTxex3xnurk38QYvnt6SS
         xDqjXN8Cr/G8rd4VXFCXObJ8UKxeO92rkuqu1hsgeYJ8CHsY/CqFT4ORWt606PWGqyeX
         KVFY0qvq+nb0jNLDH+wvGPGA7YYfHOBJfYY8iiCgxpRItDVGIuh9uRkFZUfrxzq2mzBz
         s/IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3Sg1NMnSjHVsI2sM31JWs4ZSAYtGPCK7HEDDBX1EM78=;
        fh=wt1FVLCkCB8NQL6GorIW6vdfIeB9arJpb5E5RdCR3dE=;
        b=c0yVuRXg2RkQHIZc/LbpYYFJiZAm0vT77wW2obdmw001uam19UqSAP7gftgwr7TS8D
         rAHh1rHGc15cRLFsMp6N5j5Za0wXAK337/hIFge02/w9Raoj7ob+guFp3L30HX4cWzu6
         hSghKcxDgjCGkA2VvoM0owB3tTJD3Ik5tQN7ckSqCXU0O9HK0mCCqZfKctszfGbzq+ev
         Edyr5mIMj/l92rr9R/vGfGt+JCG7cr8ZWXpD3ND6/kNg4lDW1RqJfPKg6Z0pXMcvqbfU
         TGvGeMW/auAVG7LfSwmJIxe36luKD3QXaf/SpqxLHNkpm/qK0HMoi5G1zUg0iTuhKNkq
         Pa2Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778518880; x=1779123680; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3Sg1NMnSjHVsI2sM31JWs4ZSAYtGPCK7HEDDBX1EM78=;
        b=OhEKgON80OIy1TrQ5AedbWYWvXJkLRr3IZhNN7DgZU7cyH7SrhWJYPqsAi8s4ebSD8
         KL/hzXxjAXLYxa7zvr+3Gn7GznGYwUbRik3leQDjccaZ5ps4k5p8Oeqa1njPfoxTCIJd
         AuJ3xetEIp7x11qZl++Kw2107ViILLeOq9V+p1b+y7qggJGv2/Pq34esszFLe653MJID
         r5/G03+jQ5GUNz62wHT/0nSpkNOpgNQHd99WbGzd+awgzhR9kGtFZ6ODg9PnS2X8xVzl
         7fOwO0mhLL2Y3G9RjnWjBgsc0TFS+qM+aObqnH9stxbKckFsJCiUe17KjTzjsd3hH7sf
         rS2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778518880; x=1779123680;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3Sg1NMnSjHVsI2sM31JWs4ZSAYtGPCK7HEDDBX1EM78=;
        b=M4JRp02BqUsWu/dpnhRwD2EySCnZvX3SO7I2PXOVMQuxr8Zqf0V7dAI5KMmmJlAjFE
         1QCL292plxXrQXEdmOgiiM1bQlafBvLTok5fkOuH9lyru+g1GXRV8q+WeJyQPgHnU2z8
         DZqD7rKBsXlf6dkEL6YnF9PlI/DyNY3ocsJI2zzhqe/DnHxCDZprCIPpprdMJROmogLv
         J71LpzMuKFY4HhdmyNk+UjQ3FtgP3GM9ZqWrWM67T/g6hHzaHvPoJCM6U04TsUETNQfC
         hCI9oFqbeKEwTgdUXCN7kA074widddTN/CNoX0ABmttCV0SJRaIfoUF+/ExuJlimqmlE
         w2aw==
X-Forwarded-Encrypted: i=1; AFNElJ/KjFAFLSyQl+Yi2SPOf17Y2dKdLO43G3NbBMR/rM0I+OkBtgPZdlA0HtuEXnb1z1CFeTGZfrg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJybc3a66rG+R978hAY02q2BYnBLKsVRDY08lqcXxvYfoI32T/
	amIqSvCdXHzqNMigKNg8q1Jsa8cUPUi/OP20B6c8WC/q/Pbx6LWZq87DUQLHzTWWU0KMnwkm4iK
	9112/h669AwjoN6OWgA2nDblsX9+ya0o=
X-Gm-Gg: Acq92OGKYF+889aQMHphYtGu+UtEdOh4pcerULeooeOdzvz5OEM7GecyBGCqGdhbOwl
	QmetQ2Pe/A6PBiY9/2wnxAcX7eOii2fMYzz7QLdtNHe0uHnokK1gs6qsJZGODMTDsPzRw7U03t6
	1ATIY/y2BETDX+JUyb0yUflIY+kDG5YSTB+jqzdBUTnUldn9RYJx64wXxR9zxSzDtB/MZm6Q8Qk
	7/rknnGdyO5DFSURVW85PA/8+xnGZpXQoHa3ayomGQKP+c4ly92bcff/UwbW8wyyNuvGuVk8tmC
	MFUTwZtGzC0nmH0Ul+2HJO5wHfavuQPpEdyy28BENiBziI8=
X-Received: by 2002:a05:690e:4843:b0:654:49e4:ff14 with SMTP id
 956f58d0204a3-65c79994bd2mr19456740d50.37.1778518879990; Mon, 11 May 2026
 10:01:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1778506829.git.michael.bommarito@gmail.com>
 <490e228dd02983fb1530fb114d4174148f810261.1778506829.git.michael.bommarito@gmail.com>
 <CABBYNZL-f+AzFWdhvLcxdf0oCXbgr3AXqM1W2npOPZEv0gRA6w@mail.gmail.com>
In-Reply-To: <CABBYNZL-f+AzFWdhvLcxdf0oCXbgr3AXqM1W2npOPZEv0gRA6w@mail.gmail.com>
From: Michael Bommarito <michael.bommarito@gmail.com>
Date: Mon, 11 May 2026 13:01:08 -0400
X-Gm-Features: AVHnY4JhB2d5GMH88lUH892q70_awbB8KMS0O-OtLSzvuZSSVcwIl7oatzofHYs
Message-ID: <CAJJ9bXxdm6LRW-5a4a1eDyZSQjNkJ4PNF+aERHkHe9EMQFX8oA@mail.gmail.com>
Subject: Re: [PATCH 1/4] Bluetooth: hci_sync: pin conn across hci_le_create_conn_sync
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Mat Martineau <martineau@kernel.org>, netdev@vger.kernel.org, 
	stable@vger.kernel.org, Pauli Virtanen <pav@iki.fi>, Aaron Esau <git@aaronesau.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: B297E5138BD
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-245300-lists,stable=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michaelbommarito@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	FREEMAIL_FROM(0.00)[gmail.com];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Action: no action

On Mon, May 11, 2026 at 10:53=E2=80=AFAM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> Id suggest we dropped the once at the end so just hci_cmd_sync_queue_conn=
.
>
> > +                                       hci_cmd_sync_work_func_t func,
> > +                                       struct hci_conn *conn,
> > +                                       hci_cmd_sync_work_destroy_t des=
troy)
> > +{
> > +       int err;
> > +
> > +       err =3D hci_cmd_sync_queue_once(hdev, func, hci_conn_get(conn),=
 destroy);
> > +       if (err)
> > +               hci_conn_put(conn);
> > +
> > +       return err;
>
> Then we incorporate return (err =3D=3D -EEXIST) ? 0 : err; logic above, s=
o
> I don't think any caller should require queuing multiple procedures
> for the same conn.

OK, good call.  I checked the other 10 callers for
hci_cmd_sync_queue_once and there isn't any variation today, so that
seems safe.

Do you want me to wait another 24-48 for others to weigh in or ship v2 now?

