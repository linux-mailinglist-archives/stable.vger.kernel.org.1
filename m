Return-Path: <stable+bounces-223151-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GC25Bju3qGm0wgAAu9opvQ
	(envelope-from <stable+bounces-223151-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 04 Mar 2026 23:50:35 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 779C5208C2D
	for <lists+stable@lfdr.de>; Wed, 04 Mar 2026 23:50:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8E197302D19C
	for <lists+stable@lfdr.de>; Wed,  4 Mar 2026 22:50:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97A2C38228A;
	Wed,  4 Mar 2026 22:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UwRdndyP"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C15573659F1
	for <stable@vger.kernel.org>; Wed,  4 Mar 2026 22:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772664632; cv=pass; b=ZTiJbTHY4BCgvrJUMX8C9tJuajekPLzH54R0fUe6KDuADPHwHyrwaoHYP3l/6uGcphS/ea7A8uuNWz7r5+0fN1hKxnQDKx09kZb6Wrz38/FKfxWcZB05qKvBYzAQXKURE6c2+dSYYKP6/DSaXeTQrj3PG7WURxRijYu4vfBK45E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772664632; c=relaxed/simple;
	bh=v+jTkoOuM2NPCetAIJg46/eO2RR8iZVRxxEScOdpXlI=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=teLNNvihyVr/omXsKWct8ddxkWAqHvZyPhlWnogYbwmDtxB+YgXmrAnaaJytFmRqT8uHKvQ08yAgecsegqau98meoHqkE0rbPIza2sXhyM4Om5B/D29IUbH5p48flt6ruuapfWemJfufQhrrDFcxgm7AzqlbdrOLNtlZ446GYpE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UwRdndyP; arc=pass smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-65c4152313fso10974303a12.1
        for <stable@vger.kernel.org>; Wed, 04 Mar 2026 14:50:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772664629; cv=none;
        d=google.com; s=arc-20240605;
        b=fhnHN9Kin7SnxEhSdJyKKjnC5rqqmLW4uGVvkWBbKyW1x+wj86jDy/uR13vm9RRl/g
         f5+qlIdG1TLhUSxxtb6FNwuNSG8ts3Kj8D2rSXx05CUg2MLKlrWbUHDg5okJxrUNw9J2
         /zq3VwvcJ8wmYm3Pluo01lQ7gBY4kv/R9ZOuDcaPvx8YYp+lEjYz7ecybc4myGHK2JiF
         mhrg4Y0bw5tvK4G//cauDtmcxPYbNFjrz5KqkKqPwgK24ogt9QYf0ra0Y1W8PZzc6hPm
         pO1K6yXwdOqH6aQWO1G5Nt66IN7JlF1C2G0OKIaG8g5DjqRHii4EFYvob3s2IEke9OZU
         sIXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=u+ct/ar6co3pGOjuj6b/KCIbM7ZuozKMfkuIjZQ0p24=;
        fh=cMK86hcIoTkTUj3MsfUZWNdJ8frbLqG489A2oB6PUpc=;
        b=RdrnZVziItieGdCns0XKcRG45zLUmra5GZiPzCE9RuCHsLcvSlzWHn5R/1l7oZLH1A
         L4RM0SE7emXpXOQXWrzNiwOMngQ/7zzADhOa3bYtDNWmFxGwVvVKi35oCqbZdhSJfjkR
         de7pkVPAZWh7otbheZR6+0w1BGNvZN4uRDdgwkvex4tTHW1Xm4hVJ+uC6RpUaSbDAlHU
         acXobxVMnima9q/csYw/iZJskcyZhiiJ2arHrcCiUpmnUauV9z6bvq4whlQoSQsIClBF
         rAFB+oTWS0yvFZTIzURf7AZ2ZITgKfUix1wLLZDVpvxLBEw2k6qhESc3MadKOjFWBYRL
         eL3Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772664629; x=1773269429; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=u+ct/ar6co3pGOjuj6b/KCIbM7ZuozKMfkuIjZQ0p24=;
        b=UwRdndyPaH8oO/owV+pMvihOZYFdZPdxfZAFUf2ei+OT/8knhPLq9bMEvFcOHqAikj
         X8kYySlbrtUgDxse6D5XCOViPseFfYn1E8eGm/jiOYKI0/V4s9KGmsBKu5CZmjzeIj1q
         gqRCtcU5985xznjE95E4cHiOAMAWqO4NaISJ7DAKG/nrNr6gyHxaq3PIZHNXiqU8L8IL
         5AKxh/nHzppgqwjGSe3VZhoH89bCdhYrBtBBPSbH4Cdjbe3H3JWDZi6fqzsu08Ka3eXs
         tm+lEojdPklxRM9OmMq6paQhZ2ByLxRTDEV3eHl4whWzFZ7Z5aVl5iE3+Bap6QcAp2Sw
         sVAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772664629; x=1773269429;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u+ct/ar6co3pGOjuj6b/KCIbM7ZuozKMfkuIjZQ0p24=;
        b=Den04UOPnGhgliFWZEk6Zp7sMQIQMd3G+TvhxN82z8vXfS7Pq3E+W4lN3ngaZ4mEm3
         RP0XpQLgQ7pQ9WbRWpHNfkvjlTtFGknBqXUV7JYKhEF3sysCdVet9X8Bn3TZ0eUlFE5J
         rAddb+YBhRlPQFR7tFoVmLPTSxpuQA4Y0bELWhZ5o23MiultEXpOr6GyjCrldBjD2S96
         C7iRcZZa1VUrCAXO2SkntxJh2ZWQHBBoyoynpqDzFauBg39w3vB94dtPeY3MbuPK+RRr
         qh7VWYBREP0eFDo4Zf6LIB1VUNX2QSV3gbLg6EVLp/c/diVZM1DIISKAof1qaJKb+9R+
         rnTA==
X-Forwarded-Encrypted: i=1; AJvYcCWmrCyO4p4bm1mfMgluX6VZM8IpI3s7xngSqeOwL4LgYjzQICmx7GVejejkUOX+tNdXDnktn9Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5zJ39YfgEGSPPuagoHTuQKfeMt6cDV8PHTsu9m1jENxiaL1Ux
	xIvadiTu10cf0XcaqIw9c92PVp/Rayhs30y+5cWRaYrfizAKP3oMfG3o4YC8ywf00U+cU20Dt0x
	7V3/Yggw3tQRbAucxQelMVXYC908bI43MMv0MNFM=
X-Gm-Gg: ATEYQzwLA9UIXVTQcErva74aOP1OtQwXaV7WjKe5+hjbM6CVMHkqZhjzn8MbsprUbSa
	D66/37C5vbiDRVVaz1GV5PvBbmj8yy+UPXYfmAVpkvYAbE91/hSdZsqXFlsHvu+4ZEapjRwaDKP
	IEActGXeGs0aWQu19RYoTIH/fX52fjBsDuVBiq3vmmS9Svs5Wrd1cDbndsINMTUxdaIWu2oo2ve
	q1HW3i7+GHKA7m/biehzwEn60C8jIzU0+YArTeq5b/g5IbryEEg9vFttXiGKW8/iFWQHZmP13tq
	jN89zEInqdliCVOpZB7v9Q3YREs9fKosjBadsI8qQKp/0uoMDJPhGWYbzXzMqwl0M0PN40g2FQ=
	=
X-Received: by 2002:a05:6402:234c:b0:65f:81be:e78d with SMTP id
 4fb4d7f45d1cf-660efec42e0mr2442400a12.17.1772664628867; Wed, 04 Mar 2026
 14:50:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Kai Zen <kai.aizen.dev@gmail.com>
Date: Thu, 5 Mar 2026 00:50:17 +0200
X-Gm-Features: AaiRm51dPWTiK7tvpsxWJaLOOYYndhqkdJC86YqBJtVs9MvlXc3KRn5Kf5R_r9Y
Message-ID: <CALynFi4pamOn3CrB+3b0PxhE2+Br_Ftep=VKceyeYSV65N7Y6g@mail.gmail.com>
Subject: [PATCH v2] Bluetooth: hci_conn: Fix UAF in create_big_sync and create_big_complete
To: linux-bluetooth@vger.kernel.org
Cc: luiz.von.dentz@intel.com, stable@vger.kernel.org, marcel@holtmann.org
Content-Type: multipart/mixed; boundary="00000000000082ab54064c3aa529"
X-Rspamd-Queue-Id: 779C5208C2D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,multipart/alternative,text/plain];
	MIME_BASE64_TEXT(0.10)[];
	MIME_UNKNOWN(0.10)[text/x-diff];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-223151-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+,1:+,2:+,3:~,4:~];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	TO_DN_NONE(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kaiaizendev@gmail.com,stable@vger.kernel.org];
	HAS_ATTACHMENT(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Action: no action

--00000000000082ab54064c3aa529
Content-Type: multipart/alternative; boundary="00000000000082ab52064c3aa527"

--00000000000082ab52064c3aa527
Content-Type: text/plain; charset="UTF-8"

From kai.aizen.dev@gmail.com Mon Sep 17 00:00:00 2001
From: Kai Aizen <kai.aizen.dev@gmail.com>
Date: Wed, 4 Mar 2026 20:00:00 +0200
Subject: [PATCH v2] Bluetooth: hci_conn: Fix UAF in create_big_sync and
 create_big_complete

create_big_sync() and create_big_complete() are queued via
hci_cmd_sync_queue() with a raw hci_conn pointer as 'data', but unlike
all other hci_cmd_sync_queue() callbacks that receive an hci_conn pointer
they lack an hci_conn_valid() guard.

If the connection is torn down after the work is queued but before (or
during) execution, the work dereferences a freed hci_conn object.

Race path:
 1. hci_connect_bis() queues create_big_sync(conn) on hdev->req_workqueue
 2. ISO socket close() triggers hci_conn_drop(); for BIS_LINK timeo=0,
    disc_work fires immediately on hdev->workqueue
 3. disc_work -> hci_abort_conn -> hci_conn_del() frees conn
 4. create_big_sync() dequeued and runs on req_workqueue; conn is
    already freed -> slab-use-after-free

The two workqueues are distinct (req_workqueue vs workqueue). The only
lock held by create_big_sync is hci_req_sync_lock; the deletion path
in HCI event handlers holds only hci_dev_lock. No shared lock prevents
concurrent execution.

This is the same bug class fixed for hci_enhanced_setup_sync in commit
98ccd44002d8 ("Bluetooth: hci_conn: Fix UAF in hci_enhanced_setup_sync"),
and for hci_le_create_conn_sync, hci_le_pa_create_sync,
hci_le_big_create_sync, hci_acl_create_conn_sync. create_big_sync and
create_big_complete in hci_conn.c were not included in those sweeps.

Fix: add hci_conn_valid() guard at the start of both functions. In
create_big_sync the 'qos' pointer assignment is moved past the guard
to avoid dereferencing conn before validation.

Fixes: eca0ae4aea66 ("Bluetooth: Add initial implementation of BIS
connections")
Cc: stable@vger.kernel.org
Signed-off-by: Kai Aizen <kai.aizen.dev@gmail.com>
---
 net/bluetooth/hci_conn.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index a47f5daffdbf..e7fe9cc7a4a3 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -2119,10 +2119,15 @@
 static int create_big_sync(struct hci_dev *hdev, void *data)
 {
        struct hci_conn *conn = data;
-       struct bt_iso_qos *qos = &conn->iso_qos;
        u16 interval, sync_interval = 0;
        u32 flags = 0;
        int err;
+       struct bt_iso_qos *qos;
+
+       if (!hci_conn_valid(hdev, conn))
+               return -ECANCELED;
+
+       qos = &conn->iso_qos;

        if (qos->bcast.out.phys == BIT(1))
                flags |= MGMT_ADV_FLAG_SEC_2M;
@@ -2196,6 +2201,9 @@
 {
        struct hci_conn *conn = data;

+       if (!hci_conn_valid(hdev, conn))
+               return;
+
        bt_dev_dbg(hdev, "conn %p", conn);

        if (err) {

--00000000000082ab52064c3aa527
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">From <a href=3D"mailto:kai.aizen.dev@gmail.com" target=3D=
"_blank" rel=3D"noreferrer">kai.aizen.dev@gmail.com</a> Mon Sep 17 00:00:00=
 2001<br>
From: Kai Aizen &lt;<a href=3D"mailto:kai.aizen.dev@gmail.com" target=3D"_b=
lank" rel=3D"noreferrer">kai.aizen.dev@gmail.com</a>&gt;<br>
Date: Wed, 4 Mar 2026 20:00:00 +0200<br>
Subject: [PATCH v2] Bluetooth: hci_conn: Fix UAF in create_big_sync and<br>
=C2=A0create_big_complete<br>
<br>
create_big_sync() and create_big_complete() are queued via<br>
hci_cmd_sync_queue() with a raw hci_conn pointer as &#39;data&#39;, but unl=
ike<br>
all other hci_cmd_sync_queue() callbacks that receive an hci_conn pointer<b=
r>
they lack an hci_conn_valid() guard.<br>
<br>
If the connection is torn down after the work is queued but before (or<br>
during) execution, the work dereferences a freed hci_conn object.<br>
<br>
Race path:<br>
=C2=A01. hci_connect_bis() queues create_big_sync(conn) on hdev-&gt;req_wor=
kqueue<br>
=C2=A02. ISO socket close() triggers hci_conn_drop(); for BIS_LINK timeo=3D=
0,<br>
=C2=A0 =C2=A0 disc_work fires immediately on hdev-&gt;workqueue<br>
=C2=A03. disc_work -&gt; hci_abort_conn -&gt; hci_conn_del() frees conn<br>
=C2=A04. create_big_sync() dequeued and runs on req_workqueue; conn is<br>
=C2=A0 =C2=A0 already freed -&gt; slab-use-after-free<br>
<br>
The two workqueues are distinct (req_workqueue vs workqueue). The only<br>
lock held by create_big_sync is hci_req_sync_lock; the deletion path<br>
in HCI event handlers holds only hci_dev_lock. No shared lock prevents<br>
concurrent execution.<br>
<br>
This is the same bug class fixed for hci_enhanced_setup_sync in commit<br>
98ccd44002d8 (&quot;Bluetooth: hci_conn: Fix UAF in hci_enhanced_setup_sync=
&quot;),<br>
and for hci_le_create_conn_sync, hci_le_pa_create_sync,<br>
hci_le_big_create_sync, hci_acl_create_conn_sync. create_big_sync and<br>
create_big_complete in hci_conn.c were not included in those sweeps.<br>
<br>
Fix: add hci_conn_valid() guard at the start of both functions. In<br>
create_big_sync the &#39;qos&#39; pointer assignment is moved past the guar=
d<br>
to avoid dereferencing conn before validation.<br>
<br>
Fixes: eca0ae4aea66 (&quot;Bluetooth: Add initial implementation of BIS con=
nections&quot;)<br>
Cc: <a href=3D"mailto:stable@vger.kernel.org" target=3D"_blank" rel=3D"nore=
ferrer">stable@vger.kernel.org</a><br>
Signed-off-by: Kai Aizen &lt;<a href=3D"mailto:kai.aizen.dev@gmail.com" tar=
get=3D"_blank" rel=3D"noreferrer">kai.aizen.dev@gmail.com</a>&gt;<br>
---<br>
=C2=A0net/bluetooth/hci_conn.c | 12 ++++++++++--<br>
=C2=A01 file changed, 10 insertions(+), 2 deletions(-)<br>
<br>
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c<br>
index a47f5daffdbf..e7fe9cc7a4a3 100644<br>
--- a/net/bluetooth/hci_conn.c<br>
+++ b/net/bluetooth/hci_conn.c<br>
@@ -2119,10 +2119,15 @@<br>
=C2=A0static int create_big_sync(struct hci_dev *hdev, void *data)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct hci_conn *conn =3D data;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0struct bt_iso_qos *qos =3D &amp;conn-&gt;iso_qo=
s;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 u16 interval, sync_interval =3D 0;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 u32 flags =3D 0;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 int err;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct bt_iso_qos *qos;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!hci_conn_valid(hdev, conn))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -ECANCELED;<=
br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0qos =3D &amp;conn-&gt;iso_qos;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (qos-&gt;bcast.out.phys =3D=3D BIT(1))<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 flags |=3D MGMT_ADV=
_FLAG_SEC_2M;<br>
@@ -2196,6 +2201,9 @@<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct hci_conn *conn =3D data;<br>
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!hci_conn_valid(hdev, conn))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;<br>
+<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 bt_dev_dbg(hdev, &quot;conn %p&quot;, conn);<br=
>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (err) {</div>

--00000000000082ab52064c3aa527--
--00000000000082ab54064c3aa529
Content-Type: text/x-diff; charset="ISO-8859-1"; 
	name="0001-v2-Bluetooth-hci_conn-Fix-UAF-in-create_big_sync.patch"
Content-Disposition: attachment; 
	filename="0001-v2-Bluetooth-hci_conn-Fix-UAF-in-create_big_sync.patch"
Content-Transfer-Encoding: base64
Content-ID: <19cbb0b668c18bc94a61>
X-Attachment-Id: 19cbb0b668c18bc94a61

AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAA==
--00000000000082ab54064c3aa529--

