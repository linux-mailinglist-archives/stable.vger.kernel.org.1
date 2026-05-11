Return-Path: <stable+bounces-245313-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qPMbL6QaAmofoAEAu9opvQ
	(envelope-from <stable+bounces-245313-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 20:06:28 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D7B1514104
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 20:06:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6A99B319047E
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 17:35:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EADC4657F1;
	Mon, 11 May 2026 17:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bc4Hyq64"
X-Original-To: stable@vger.kernel.org
Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com [74.125.224.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A8A9450902
	for <stable@vger.kernel.org>; Mon, 11 May 2026 17:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778520944; cv=pass; b=md0iZe4PldC0WZIRtrt/Y6LrhmT5LRsG2TRPrrFRXYaMWpkmUpB4sa9hEaO1JNDOumOZO7JmkiTj2EdzvYaQvpST9BIMgQEW1NPUK4lRm5GAdFe/koffGUw+j1riek4UgeFwIhOqo309WNbD8ta+qkgkMMqJyRFKuvwPWvlGW+o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778520944; c=relaxed/simple;
	bh=PrHitHZsoYkpOMvbmxI3GoouXwZw7Mpx8RnnPHK+sF8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=exY8IG9+Y/5UfBVUcGV9zuua9qVcQ74b35an3F+nBIK9XATpu5Pg+7wqJJ4gR2q0Uh/NrW3L3Y+fiZjp7am1eCc8IHLKQzZOuv5ee9kGtYyZUpyZIrGFYQVWmqaWCivEyvsjtGgPHOOgdoOXdIciQA/XwLl3cFmgiTjFoFXd8/Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bc4Hyq64; arc=pass smtp.client-ip=74.125.224.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f44.google.com with SMTP id 956f58d0204a3-65dbe04fc1bso1394554d50.1
        for <stable@vger.kernel.org>; Mon, 11 May 2026 10:35:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778520942; cv=none;
        d=google.com; s=arc-20240605;
        b=WUNlGsVmjUDw4jwganGjs9p4+NgvF5Cv+g9qWcqQyec00Xfh0JfQ+QS/PMuktIC1bT
         BnQMzQxTKh3NH3yTnJWkYtzFIB5oeYa7agc/iCbJ0tqxlR3xraeS71DlwU1yOkvA6+ou
         rJUtHFOV9xSMLf3w2HQoJ2Ws3m1xULLvrE/3oiYQku46LSmA9/y8RrSKm+3xL+zadkmv
         vqJCrCqP9LNLiwbS1nhLZxGdcVVfTxBolOigf4JRJaJ0hP4fUdkW7ITHqYXhTbURD0ty
         6uS0efRV6VCeVH/ltkRgpGCVmtooN+I6sZSpUmYYZlB4dmTn/uj4o6cud6bFzTHpkZjD
         SiXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=dlz/dzPv3rXYhFqA+0mmgm8FDTZKSNmwOlN+ACRup7M=;
        fh=o9GpgVYvGsI3wpJYplX/EHKpWX+OztrUPRIErhhrBO0=;
        b=AOJB99UOmtM4rFfzVGMi19A21BZAjVkTxyuB+zXQRtyC0iyrHzwhT3VW0yDFBlhVqE
         Xi0iY5vJ0X07xxkhF8NHPWXIlarWHSguK+4A94SNFZO9x2gv1CU4c2H7zvOk7PJCLTxj
         4tsp6XXZvPQWGDzd7ocdZEm0bfALK0G0hDi1TQcFWtu9Wgy+3ZM8Oel6KVPKL3iCED0J
         31UmGcJm0gbXnaCwZ0+MrxszWXRdSnbHlsZAbxJ+YpFjzkTGUefBt2GcUyRqx87pwuc+
         ZjKlDrrnosKfdsJyDOuXogv4WmvH2TXP+OIUO3zV7D6Sliwd/sqMgu+j16AAxILGHcTu
         +v8g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778520942; x=1779125742; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dlz/dzPv3rXYhFqA+0mmgm8FDTZKSNmwOlN+ACRup7M=;
        b=bc4Hyq6422T08nEavjrv0nDDz85pVXB3eTqJKoNwnpdT8bP8Bcl4KiEc2T32rsGCnR
         rQBiLxpofKw27UTTEer8HxQMuuFQTNtybfmTHLOUcjFC01b2futXIZnJkpAf/SxRAe5T
         4IEBJR4+6A0JQ3lmblaixA6Xavv2Su0YfU2Rxoiszu/K1wy8M1QdSJGMbIRL5xLuddKT
         olhNLsqOa2ZxCDocaVSA3GDhEbP3Axifd2YAiQnkt5xF2MReURk6aZ9vftmjn0Zt5k5k
         WnR9mEMats8f+i9zBxTrDwuT/CA4g0+RXlEeN+f5nGBaitZynX1AK+/iRbTkWQEqi6Lk
         hCTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778520942; x=1779125742;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dlz/dzPv3rXYhFqA+0mmgm8FDTZKSNmwOlN+ACRup7M=;
        b=P8SepRXCULQnFy2O2xXq+UQZLpvD9K2ZJsXbtnr5TsGTIpqcxDhYLgyCd0UnRvC5ME
         gh/yCYKik1k/h1lwWGaxy6bvCeoSZ8uhcEQGabRlgfia/JYU4cCbbXOJdsfdWuQmIZ3Z
         IVVDgtMM5V+NJ4sDyLKxxTnz2B/5MaTnpIg9dIWRYKVc2jQichTwU3jRVplyVvMjFzn8
         2Ge0GG8Bh5JrlMu2UcPFgmCvoSepkUygPtTRa3QauwnEANwlUMh0V4N1+mSHj/t0MAbD
         3CTaXyUWNX6okUNMG+IyW3hRMoAd900VcZWxvINGjwv+pQMl9IOK5azDDNvO+hfFH12X
         Jd3g==
X-Forwarded-Encrypted: i=1; AFNElJ9cvRVsMHNe5stTzHo4R7pAV8rrStR4hiSy99js3jjGmFyTcirYksOr5UvOj9/jMYRteHyMexE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUOvV1e/FsPQfCFrJIgq+iittxJV8nVooGxggF4ifuj2Jm8yjv
	hWLioy/lbLhGcWlW4mAYxdI3vpjGyd2g5FDxmnl4Rk/NQS8qfMpyzNwrz67Dtfojc65wC+f0JUJ
	VUQ/U9iYJdIeBXlakbPhhiyiD6si2Uu0=
X-Gm-Gg: Acq92OGYUHrLcAnxrAnuuUPkwucfKzkNp7IEtpGAMP4kha+1inAl0RUUP0cPNMQyBuG
	edBipLf9bO3mZKjrCBcRy+gUXqS9HDXQ8fBzzQF+Wr6ulGzZZL6UUblQcF3CXpB2M87KRf64Fu8
	GC0k7jd11WzJ/hxCtbdJRHc0TWwmxl2ymhyji0EnlXpQEZz9zDQ94VyJzcIihOkVFdC4X9EA5HS
	Vs3qgGBvMO6QZ+Z43LN+TSVKO+4cMuI2EObyCRnbbz+yrHb6TxzQ/HTgGBdaVrgjyD6GIgwT53o
	hyB91yH2ks2vAuBnM2aDQNK6Zmu0HaN+QS/G5Ic43KihpIwuuDSAITCrq+rsjC9aOLbIoA==
X-Received: by 2002:a05:690e:120d:b0:65d:8123:25e5 with SMTP id
 956f58d0204a3-65d94afdef1mr13964872d50.7.1778520942181; Mon, 11 May 2026
 10:35:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1778506829.git.michael.bommarito@gmail.com>
 <490e228dd02983fb1530fb114d4174148f810261.1778506829.git.michael.bommarito@gmail.com>
 <CABBYNZL-f+AzFWdhvLcxdf0oCXbgr3AXqM1W2npOPZEv0gRA6w@mail.gmail.com> <CAJJ9bXxdm6LRW-5a4a1eDyZSQjNkJ4PNF+aERHkHe9EMQFX8oA@mail.gmail.com>
In-Reply-To: <CAJJ9bXxdm6LRW-5a4a1eDyZSQjNkJ4PNF+aERHkHe9EMQFX8oA@mail.gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 11 May 2026 13:35:30 -0400
X-Gm-Features: AVHnY4L-7jwHCz-ogOtNC6Z8VESGLPAPWW1nNwcsCVS7lrb7wnAJ7aIMYilRan0
Message-ID: <CABBYNZ+nyk+hZ498373bLJ0dOkDbNqP0PyoH5MWsPerHhBSfLA@mail.gmail.com>
Subject: Re: [PATCH 1/4] Bluetooth: hci_sync: pin conn across hci_le_create_conn_sync
To: Michael Bommarito <michael.bommarito@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Mat Martineau <martineau@kernel.org>, netdev@vger.kernel.org, 
	stable@vger.kernel.org, Pauli Virtanen <pav@iki.fi>, Aaron Esau <git@aaronesau.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 1D7B1514104
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-245313-lists,stable=lfdr.de];
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
	FROM_NEQ_ENVFROM(0.00)[luizdentz@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	FREEMAIL_FROM(0.00)[gmail.com];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Hi Michael,

On Mon, May 11, 2026 at 1:01=E2=80=AFPM Michael Bommarito
<michael.bommarito@gmail.com> wrote:
>
> On Mon, May 11, 2026 at 10:53=E2=80=AFAM Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
> > Id suggest we dropped the once at the end so just hci_cmd_sync_queue_co=
nn.
> >
> > > +                                       hci_cmd_sync_work_func_t func=
,
> > > +                                       struct hci_conn *conn,
> > > +                                       hci_cmd_sync_work_destroy_t d=
estroy)
> > > +{
> > > +       int err;
> > > +
> > > +       err =3D hci_cmd_sync_queue_once(hdev, func, hci_conn_get(conn=
), destroy);
> > > +       if (err)
> > > +               hci_conn_put(conn);
> > > +
> > > +       return err;
> >
> > Then we incorporate return (err =3D=3D -EEXIST) ? 0 : err; logic above,=
 so
> > I don't think any caller should require queuing multiple procedures
> > for the same conn.
>
> OK, good call.  I checked the other 10 callers for
> hci_cmd_sync_queue_once and there isn't any variation today, so that
> seems safe.
>
> Do you want me to wait another 24-48 for others to weigh in or ship v2 no=
w?

Just create a v2, anyone with comments can add them there as well.

--=20
Luiz Augusto von Dentz

