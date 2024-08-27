Return-Path: <stable+bounces-70289-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 47A8595FF21
	for <lists+stable@lfdr.de>; Tue, 27 Aug 2024 04:31:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C40DF1F22FD5
	for <lists+stable@lfdr.de>; Tue, 27 Aug 2024 02:31:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EA02C8FE;
	Tue, 27 Aug 2024 02:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fhBT0K1o"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1C54C8D7
	for <stable@vger.kernel.org>; Tue, 27 Aug 2024 02:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724725853; cv=none; b=H07U41Iw3AzV+qRAvFwx7760Msg1Bct0kDk7Shf0eVvy/eiajDK+7s6f7LP9tbiQZ2aStBxveg3UR9n+XiY6lvYccFJgJVlmCNH67NgD9t9/4ePLHI4N0iK3+imKZ/P0lsA61F/c9DL5FuRL8i5B2JS0rNNOEUWgfK6pG6hMwU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724725853; c=relaxed/simple;
	bh=zMYgyfYb4wfEvZYncZ781gDAF0HFX1ONXXK3Ore1Z80=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dhlLTvu8gwWjUCJPPPPNASFB7Qfph4T6bAJZc59/bOT2QMbXfBzHjyZ2vNhNjia6EvNMLDeOa4Nzj7+8K47UKXlTS+2sJqQ7LRIVw55lgBUINPuVH8na058vDvScaXZlBQRc71qmv35y3YVuwBgoEpKdVZ+rBCW4w4GDSIkAVhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fhBT0K1o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68114C8B7A4
	for <stable@vger.kernel.org>; Tue, 27 Aug 2024 02:30:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724725852;
	bh=zMYgyfYb4wfEvZYncZ781gDAF0HFX1ONXXK3Ore1Z80=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=fhBT0K1olglDmdNLPf0V5OkdtEY0gsRHTYyGvbwwr5PsKXebJb36MoOPo7LiE8u6F
	 lCSAvgmwvsXK/LR74Y+WjFXvAYvNF139vzcIgoCKz3YnHNOZEmpMdv4xuHf4mM6+52
	 7KIk5PB1mtVFhTP71PNCQij1zMCElQ8q+JYdbf3TqFC0o5pvWbFgssBJNB/N9XZI+H
	 n7M4h3xi8KfFy6kz2FcPUfg/IT1yjL+YcXSHYlWizewzir9/wkHU7eNdWcSuJtgfpw
	 cRtOzR6GF/+XSGRAVPmhHngIUkOQcNJyjt0LJcAAl2xtYZmMKu6it26hX/K8dTZzd4
	 wIbRiuc+enLhg==
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-2701824beeeso3861165fac.1
        for <stable@vger.kernel.org>; Mon, 26 Aug 2024 19:30:52 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWMkCMoc7pxiI2UgjC3yUrglBk/KDvC5Jx13QTKuc6MhgHCnBK2sEXCmVlu+bucql/2twPgFko=@vger.kernel.org
X-Gm-Message-State: AOJu0YziWEl2UnLrtNP4l8tq/3ac2HD6o9dqYpMEAQdExXlk1jMAufUT
	jCXm8+U75pZ9aVW19fzW6phT/zvwhc1BcnY9odVz9gf6znYSZpajoTFRPS8RckkPm1iPUSqc7nx
	pPt8G7fXFBrGfRoML6tyrvQKEsow=
X-Google-Smtp-Source: AGHT+IEU9cW72YAgsUYB1xP6RV1tb1zs2z45Nq3GuSUPG7MrmODrgN5uqZdu4MCY5clMjmY7yHOd72S6imrtghnNzS4=
X-Received: by 2002:a05:6870:224f:b0:268:b4b6:91ab with SMTP id
 586e51a60fabf-273e647691emr14676168fac.18.1724725851738; Mon, 26 Aug 2024
 19:30:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2024082625-savior-clinic-1a91@gregkh>
In-Reply-To: <2024082625-savior-clinic-1a91@gregkh>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Tue, 27 Aug 2024 11:30:40 +0900
X-Gmail-Original-Message-ID: <CAKYAXd_MPF9WiFoOwnPBiPvwMKDjGJ4BX4u-UnGymFM4sp3YMQ@mail.gmail.com>
Message-ID: <CAKYAXd_MPF9WiFoOwnPBiPvwMKDjGJ4BX4u-UnGymFM4sp3YMQ@mail.gmail.com>
Subject: Re: FAILED: patch "[PATCH] ksmbd: fix race condition between
 destroy_previous_session()" failed to apply to 6.10-stable tree
To: gregkh@linuxfoundation.org
Cc: stfrench@microsoft.com, stable@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000baaaa80620a1071a"

--000000000000baaaa80620a1071a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 26, 2024 at 8:38=E2=80=AFPM <gregkh@linuxfoundation.org> wrote:
>
>
> The patch below does not apply to the 6.10-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.
Could you please apply the attached backport patch for linux 6.10
stable kernel ?

Thanks!

>
> To reproduce the conflict and resubmit, you may use the following command=
s:
>
> git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.gi=
t/ linux-6.10.y
> git checkout FETCH_HEAD
> git cherry-pick -x 76e98a158b207771a6c9a0de0a60522a446a3447
> # <resolve conflicts, build, test, etc.>
> git commit -s
> git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024082625-=
savior-clinic-1a91@gregkh' --subject-prefix 'PATCH 6.10.y' HEAD^..
>
> Possible dependencies:
>
> 76e98a158b20 ("ksmbd: fix race condition between destroy_previous_session=
() and smb2 operations()")
> d484d621d40f ("ksmbd: add durable scavenger timer")
>
> thanks,
>
> greg k-h
>
> ------------------ original commit in Linus's tree ------------------
>
> From 76e98a158b207771a6c9a0de0a60522a446a3447 Mon Sep 17 00:00:00 2001
> From: Namjae Jeon <linkinjeon@kernel.org>
> Date: Sat, 17 Aug 2024 14:03:49 +0900
> Subject: [PATCH] ksmbd: fix race condition between destroy_previous_sessi=
on()
>  and smb2 operations()
>
> If there is ->PreviousSessionId field in the session setup request,
> The session of the previous connection should be destroyed.
> During this, if the smb2 operation requests in the previous session are
> being processed, a racy issue could happen with ksmbd_destroy_file_table(=
).
> This patch sets conn->status to KSMBD_SESS_NEED_RECONNECT to block
> incoming  operations and waits until on-going operations are complete
> (i.e. idle) before desctorying the previous session.
>
> Fixes: c8efcc786146 ("ksmbd: add support for durable handles v1/v2")
> Cc: stable@vger.kernel.org # v6.6+
> Reported-by: zdi-disclosures@trendmicro.com # ZDI-CAN-25040
> Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
> Signed-off-by: Steve French <stfrench@microsoft.com>
>
> diff --git a/fs/smb/server/connection.c b/fs/smb/server/connection.c
> index 09e1e7771592..7889df8112b4 100644
> --- a/fs/smb/server/connection.c
> +++ b/fs/smb/server/connection.c
> @@ -165,11 +165,43 @@ void ksmbd_all_conn_set_status(u64 sess_id, u32 sta=
tus)
>         up_read(&conn_list_lock);
>  }
>
> -void ksmbd_conn_wait_idle(struct ksmbd_conn *conn, u64 sess_id)
> +void ksmbd_conn_wait_idle(struct ksmbd_conn *conn)
>  {
>         wait_event(conn->req_running_q, atomic_read(&conn->req_running) <=
 2);
>  }
>
> +int ksmbd_conn_wait_idle_sess_id(struct ksmbd_conn *curr_conn, u64 sess_=
id)
> +{
> +       struct ksmbd_conn *conn;
> +       int rc, retry_count =3D 0, max_timeout =3D 120;
> +       int rcount =3D 1;
> +
> +retry_idle:
> +       if (retry_count >=3D max_timeout)
> +               return -EIO;
> +
> +       down_read(&conn_list_lock);
> +       list_for_each_entry(conn, &conn_list, conns_list) {
> +               if (conn->binding || xa_load(&conn->sessions, sess_id)) {
> +                       if (conn =3D=3D curr_conn)
> +                               rcount =3D 2;
> +                       if (atomic_read(&conn->req_running) >=3D rcount) =
{
> +                               rc =3D wait_event_timeout(conn->req_runni=
ng_q,
> +                                       atomic_read(&conn->req_running) <=
 rcount,
> +                                       HZ);
> +                               if (!rc) {
> +                                       up_read(&conn_list_lock);
> +                                       retry_count++;
> +                                       goto retry_idle;
> +                               }
> +                       }
> +               }
> +       }
> +       up_read(&conn_list_lock);
> +
> +       return 0;
> +}
> +
>  int ksmbd_conn_write(struct ksmbd_work *work)
>  {
>         struct ksmbd_conn *conn =3D work->conn;
> diff --git a/fs/smb/server/connection.h b/fs/smb/server/connection.h
> index 5c2845e47cf2..5b947175c048 100644
> --- a/fs/smb/server/connection.h
> +++ b/fs/smb/server/connection.h
> @@ -145,7 +145,8 @@ extern struct list_head conn_list;
>  extern struct rw_semaphore conn_list_lock;
>
>  bool ksmbd_conn_alive(struct ksmbd_conn *conn);
> -void ksmbd_conn_wait_idle(struct ksmbd_conn *conn, u64 sess_id);
> +void ksmbd_conn_wait_idle(struct ksmbd_conn *conn);
> +int ksmbd_conn_wait_idle_sess_id(struct ksmbd_conn *curr_conn, u64 sess_=
id);
>  struct ksmbd_conn *ksmbd_conn_alloc(void);
>  void ksmbd_conn_free(struct ksmbd_conn *conn);
>  bool ksmbd_conn_lookup_dialect(struct ksmbd_conn *c);
> diff --git a/fs/smb/server/mgmt/user_session.c b/fs/smb/server/mgmt/user_=
session.c
> index 162a12685d2c..99416ce9f501 100644
> --- a/fs/smb/server/mgmt/user_session.c
> +++ b/fs/smb/server/mgmt/user_session.c
> @@ -311,6 +311,7 @@ void destroy_previous_session(struct ksmbd_conn *conn=
,
>  {
>         struct ksmbd_session *prev_sess;
>         struct ksmbd_user *prev_user;
> +       int err;
>
>         down_write(&sessions_table_lock);
>         down_write(&conn->session_lock);
> @@ -325,8 +326,16 @@ void destroy_previous_session(struct ksmbd_conn *con=
n,
>             memcmp(user->passkey, prev_user->passkey, user->passkey_sz))
>                 goto out;
>
> +       ksmbd_all_conn_set_status(id, KSMBD_SESS_NEED_RECONNECT);
> +       err =3D ksmbd_conn_wait_idle_sess_id(conn, id);
> +       if (err) {
> +               ksmbd_all_conn_set_status(id, KSMBD_SESS_NEED_NEGOTIATE);
> +               goto out;
> +       }
> +
>         ksmbd_destroy_file_table(&prev_sess->file_table);
>         prev_sess->state =3D SMB2_SESSION_EXPIRED;
> +       ksmbd_all_conn_set_status(id, KSMBD_SESS_NEED_NEGOTIATE);
>         ksmbd_launch_ksmbd_durable_scavenger();
>  out:
>         up_write(&conn->session_lock);
> diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
> index 3f4c56a10a86..cb7f487c96af 100644
> --- a/fs/smb/server/smb2pdu.c
> +++ b/fs/smb/server/smb2pdu.c
> @@ -2213,7 +2213,7 @@ int smb2_session_logoff(struct ksmbd_work *work)
>         ksmbd_conn_unlock(conn);
>
>         ksmbd_close_session_fds(work);
> -       ksmbd_conn_wait_idle(conn, sess_id);
> +       ksmbd_conn_wait_idle(conn);
>
>         /*
>          * Re-lookup session to validate if session is deleted
>

--000000000000baaaa80620a1071a
Content-Type: application/x-patch; 
	name="0001-ksmbd-fix-race-condition-between-destroy_previous_se.patch"
Content-Disposition: attachment; 
	filename="0001-ksmbd-fix-race-condition-between-destroy_previous_se.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_m0bt3zok0>
X-Attachment-Id: f_m0bt3zok0

RnJvbSA5ZTBhM2QzOWEzNmY4MGZkMzliNWVjMmY5NDNiOTUxNGJiYTFlOWJkIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBOYW1qYWUgSmVvbiA8bGlua2luamVvbkBrZXJuZWwub3JnPgpE
YXRlOiBUdWUsIDI3IEF1ZyAyMDI0IDA5OjI3OjU2ICswOTAwClN1YmplY3Q6IFtQQVRDSCBsaW51
eC02LjEwLnkgXSBrc21iZDogZml4IHJhY2UgY29uZGl0aW9uIGJldHdlZW4gZGVzdHJveV9wcmV2
aW91c19zZXNzaW9uKCkKIGFuZCBzbWIyIG9wZXJhdGlvbnMoKQoKWyBVcHN0cmVhbSBjb21taXQg
NzZlOThhMTU4YjIwNzc3MWE2YzlhMGRlMGE2MDUyMmE0NDZhMzQ0NyBdCgpJZiB0aGVyZSBpcyAt
PlByZXZpb3VzU2Vzc2lvbklkIGZpZWxkIGluIHRoZSBzZXNzaW9uIHNldHVwIHJlcXVlc3QsClRo
ZSBzZXNzaW9uIG9mIHRoZSBwcmV2aW91cyBjb25uZWN0aW9uIHNob3VsZCBiZSBkZXN0cm95ZWQu
CkR1cmluZyB0aGlzLCBpZiB0aGUgc21iMiBvcGVyYXRpb24gcmVxdWVzdHMgaW4gdGhlIHByZXZp
b3VzIHNlc3Npb24gYXJlCmJlaW5nIHByb2Nlc3NlZCwgYSByYWN5IGlzc3VlIGNvdWxkIGhhcHBl
biB3aXRoIGtzbWJkX2Rlc3Ryb3lfZmlsZV90YWJsZSgpLgpUaGlzIHBhdGNoIHNldHMgY29ubi0+
c3RhdHVzIHRvIEtTTUJEX1NFU1NfTkVFRF9SRUNPTk5FQ1QgdG8gYmxvY2sKaW5jb21pbmcgIG9w
ZXJhdGlvbnMgYW5kIHdhaXRzIHVudGlsIG9uLWdvaW5nIG9wZXJhdGlvbnMgYXJlIGNvbXBsZXRl
CihpLmUuIGlkbGUpIGJlZm9yZSBkZXNjdG9yeWluZyB0aGUgcHJldmlvdXMgc2Vzc2lvbi4KCkZp
eGVzOiBjOGVmY2M3ODYxNDYgKCJrc21iZDogYWRkIHN1cHBvcnQgZm9yIGR1cmFibGUgaGFuZGxl
cyB2MS92MiIpCkNjOiBzdGFibGVAdmdlci5rZXJuZWwub3JnICMgdjYuNisKUmVwb3J0ZWQtYnk6
IHpkaS1kaXNjbG9zdXJlc0B0cmVuZG1pY3JvLmNvbSAjIFpESS1DQU4tMjUwNDAKU2lnbmVkLW9m
Zi1ieTogTmFtamFlIEplb24gPGxpbmtpbmplb25Aa2VybmVsLm9yZz4KU2lnbmVkLW9mZi1ieTog
U3RldmUgRnJlbmNoIDxzdGZyZW5jaEBtaWNyb3NvZnQuY29tPgotLS0KIGZzL3NtYi9zZXJ2ZXIv
Y29ubmVjdGlvbi5jICAgICAgICB8IDM0ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0K
IGZzL3NtYi9zZXJ2ZXIvY29ubmVjdGlvbi5oICAgICAgICB8ICAzICsrLQogZnMvc21iL3NlcnZl
ci9tZ210L3VzZXJfc2Vzc2lvbi5jIHwgIDggKysrKysrKysKIGZzL3NtYi9zZXJ2ZXIvc21iMnBk
dS5jICAgICAgICAgICB8ICAyICstCiA0IGZpbGVzIGNoYW5nZWQsIDQ0IGluc2VydGlvbnMoKyks
IDMgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZnMvc21iL3NlcnZlci9jb25uZWN0aW9uLmMg
Yi9mcy9zbWIvc2VydmVyL2Nvbm5lY3Rpb24uYwppbmRleCAwOWUxZTc3NzE1OTIuLjc4ODlkZjgx
MTJiNCAxMDA2NDQKLS0tIGEvZnMvc21iL3NlcnZlci9jb25uZWN0aW9uLmMKKysrIGIvZnMvc21i
L3NlcnZlci9jb25uZWN0aW9uLmMKQEAgLTE2NSwxMSArMTY1LDQzIEBAIHZvaWQga3NtYmRfYWxs
X2Nvbm5fc2V0X3N0YXR1cyh1NjQgc2Vzc19pZCwgdTMyIHN0YXR1cykKIAl1cF9yZWFkKCZjb25u
X2xpc3RfbG9jayk7CiB9CiAKLXZvaWQga3NtYmRfY29ubl93YWl0X2lkbGUoc3RydWN0IGtzbWJk
X2Nvbm4gKmNvbm4sIHU2NCBzZXNzX2lkKQordm9pZCBrc21iZF9jb25uX3dhaXRfaWRsZShzdHJ1
Y3Qga3NtYmRfY29ubiAqY29ubikKIHsKIAl3YWl0X2V2ZW50KGNvbm4tPnJlcV9ydW5uaW5nX3Es
IGF0b21pY19yZWFkKCZjb25uLT5yZXFfcnVubmluZykgPCAyKTsKIH0KIAoraW50IGtzbWJkX2Nv
bm5fd2FpdF9pZGxlX3Nlc3NfaWQoc3RydWN0IGtzbWJkX2Nvbm4gKmN1cnJfY29ubiwgdTY0IHNl
c3NfaWQpCit7CisJc3RydWN0IGtzbWJkX2Nvbm4gKmNvbm47CisJaW50IHJjLCByZXRyeV9jb3Vu
dCA9IDAsIG1heF90aW1lb3V0ID0gMTIwOworCWludCByY291bnQgPSAxOworCityZXRyeV9pZGxl
OgorCWlmIChyZXRyeV9jb3VudCA+PSBtYXhfdGltZW91dCkKKwkJcmV0dXJuIC1FSU87CisKKwlk
b3duX3JlYWQoJmNvbm5fbGlzdF9sb2NrKTsKKwlsaXN0X2Zvcl9lYWNoX2VudHJ5KGNvbm4sICZj
b25uX2xpc3QsIGNvbm5zX2xpc3QpIHsKKwkJaWYgKGNvbm4tPmJpbmRpbmcgfHwgeGFfbG9hZCgm
Y29ubi0+c2Vzc2lvbnMsIHNlc3NfaWQpKSB7CisJCQlpZiAoY29ubiA9PSBjdXJyX2Nvbm4pCisJ
CQkJcmNvdW50ID0gMjsKKwkJCWlmIChhdG9taWNfcmVhZCgmY29ubi0+cmVxX3J1bm5pbmcpID49
IHJjb3VudCkgeworCQkJCXJjID0gd2FpdF9ldmVudF90aW1lb3V0KGNvbm4tPnJlcV9ydW5uaW5n
X3EsCisJCQkJCWF0b21pY19yZWFkKCZjb25uLT5yZXFfcnVubmluZykgPCByY291bnQsCisJCQkJ
CUhaKTsKKwkJCQlpZiAoIXJjKSB7CisJCQkJCXVwX3JlYWQoJmNvbm5fbGlzdF9sb2NrKTsKKwkJ
CQkJcmV0cnlfY291bnQrKzsKKwkJCQkJZ290byByZXRyeV9pZGxlOworCQkJCX0KKwkJCX0KKwkJ
fQorCX0KKwl1cF9yZWFkKCZjb25uX2xpc3RfbG9jayk7CisKKwlyZXR1cm4gMDsKK30KKwogaW50
IGtzbWJkX2Nvbm5fd3JpdGUoc3RydWN0IGtzbWJkX3dvcmsgKndvcmspCiB7CiAJc3RydWN0IGtz
bWJkX2Nvbm4gKmNvbm4gPSB3b3JrLT5jb25uOwpkaWZmIC0tZ2l0IGEvZnMvc21iL3NlcnZlci9j
b25uZWN0aW9uLmggYi9mcy9zbWIvc2VydmVyL2Nvbm5lY3Rpb24uaAppbmRleCAwZTA0Y2Y4YjFk
ODkuLmI5M2U1NDM3NzkzZSAxMDA2NDQKLS0tIGEvZnMvc21iL3NlcnZlci9jb25uZWN0aW9uLmgK
KysrIGIvZnMvc21iL3NlcnZlci9jb25uZWN0aW9uLmgKQEAgLTE0NSw3ICsxNDUsOCBAQCBleHRl
cm4gc3RydWN0IGxpc3RfaGVhZCBjb25uX2xpc3Q7CiBleHRlcm4gc3RydWN0IHJ3X3NlbWFwaG9y
ZSBjb25uX2xpc3RfbG9jazsKIAogYm9vbCBrc21iZF9jb25uX2FsaXZlKHN0cnVjdCBrc21iZF9j
b25uICpjb25uKTsKLXZvaWQga3NtYmRfY29ubl93YWl0X2lkbGUoc3RydWN0IGtzbWJkX2Nvbm4g
KmNvbm4sIHU2NCBzZXNzX2lkKTsKK3ZvaWQga3NtYmRfY29ubl93YWl0X2lkbGUoc3RydWN0IGtz
bWJkX2Nvbm4gKmNvbm4pOworaW50IGtzbWJkX2Nvbm5fd2FpdF9pZGxlX3Nlc3NfaWQoc3RydWN0
IGtzbWJkX2Nvbm4gKmN1cnJfY29ubiwgdTY0IHNlc3NfaWQpOwogc3RydWN0IGtzbWJkX2Nvbm4g
KmtzbWJkX2Nvbm5fYWxsb2Modm9pZCk7CiB2b2lkIGtzbWJkX2Nvbm5fZnJlZShzdHJ1Y3Qga3Nt
YmRfY29ubiAqY29ubik7CiBib29sIGtzbWJkX2Nvbm5fbG9va3VwX2RpYWxlY3Qoc3RydWN0IGtz
bWJkX2Nvbm4gKmMpOwpkaWZmIC0tZ2l0IGEvZnMvc21iL3NlcnZlci9tZ210L3VzZXJfc2Vzc2lv
bi5jIGIvZnMvc21iL3NlcnZlci9tZ210L3VzZXJfc2Vzc2lvbi5jCmluZGV4IGFlYzBhN2ExMjQw
NS4uZGFjNWY5ODRmMTc1IDEwMDY0NAotLS0gYS9mcy9zbWIvc2VydmVyL21nbXQvdXNlcl9zZXNz
aW9uLmMKKysrIGIvZnMvc21iL3NlcnZlci9tZ210L3VzZXJfc2Vzc2lvbi5jCkBAIC0zMTAsNiAr
MzEwLDcgQEAgdm9pZCBkZXN0cm95X3ByZXZpb3VzX3Nlc3Npb24oc3RydWN0IGtzbWJkX2Nvbm4g
KmNvbm4sCiB7CiAJc3RydWN0IGtzbWJkX3Nlc3Npb24gKnByZXZfc2VzczsKIAlzdHJ1Y3Qga3Nt
YmRfdXNlciAqcHJldl91c2VyOworCWludCBlcnI7CiAKIAlkb3duX3dyaXRlKCZzZXNzaW9uc190
YWJsZV9sb2NrKTsKIAlkb3duX3dyaXRlKCZjb25uLT5zZXNzaW9uX2xvY2spOwpAQCAtMzI0LDgg
KzMyNSwxNSBAQCB2b2lkIGRlc3Ryb3lfcHJldmlvdXNfc2Vzc2lvbihzdHJ1Y3Qga3NtYmRfY29u
biAqY29ubiwKIAkgICAgbWVtY21wKHVzZXItPnBhc3NrZXksIHByZXZfdXNlci0+cGFzc2tleSwg
dXNlci0+cGFzc2tleV9zeikpCiAJCWdvdG8gb3V0OwogCisJa3NtYmRfYWxsX2Nvbm5fc2V0X3N0
YXR1cyhpZCwgS1NNQkRfU0VTU19ORUVEX1JFQ09OTkVDVCk7CisJZXJyID0ga3NtYmRfY29ubl93
YWl0X2lkbGVfc2Vzc19pZChjb25uLCBpZCk7CisJaWYgKGVycikgeworCQlrc21iZF9hbGxfY29u
bl9zZXRfc3RhdHVzKGlkLCBLU01CRF9TRVNTX05FRURfTkVHT1RJQVRFKTsKKwkJZ290byBvdXQ7
CisJfQogCWtzbWJkX2Rlc3Ryb3lfZmlsZV90YWJsZSgmcHJldl9zZXNzLT5maWxlX3RhYmxlKTsK
IAlwcmV2X3Nlc3MtPnN0YXRlID0gU01CMl9TRVNTSU9OX0VYUElSRUQ7CisJa3NtYmRfYWxsX2Nv
bm5fc2V0X3N0YXR1cyhpZCwgS1NNQkRfU0VTU19ORUVEX05FR09USUFURSk7CiBvdXQ6CiAJdXBf
d3JpdGUoJmNvbm4tPnNlc3Npb25fbG9jayk7CiAJdXBfd3JpdGUoJnNlc3Npb25zX3RhYmxlX2xv
Y2spOwpkaWZmIC0tZ2l0IGEvZnMvc21iL3NlcnZlci9zbWIycGR1LmMgYi9mcy9zbWIvc2VydmVy
L3NtYjJwZHUuYwppbmRleCA1OTJhMmNkZmQwNjcuLjQ1MzdlYThmZDNlNSAxMDA2NDQKLS0tIGEv
ZnMvc21iL3NlcnZlci9zbWIycGR1LmMKKysrIGIvZnMvc21iL3NlcnZlci9zbWIycGR1LmMKQEAg
LTIyMTAsNyArMjIxMCw3IEBAIGludCBzbWIyX3Nlc3Npb25fbG9nb2ZmKHN0cnVjdCBrc21iZF93
b3JrICp3b3JrKQogCWtzbWJkX2Nvbm5fdW5sb2NrKGNvbm4pOwogCiAJa3NtYmRfY2xvc2Vfc2Vz
c2lvbl9mZHMod29yayk7Ci0Ja3NtYmRfY29ubl93YWl0X2lkbGUoY29ubiwgc2Vzc19pZCk7CisJ
a3NtYmRfY29ubl93YWl0X2lkbGUoY29ubik7CiAKIAkvKgogCSAqIFJlLWxvb2t1cCBzZXNzaW9u
IHRvIHZhbGlkYXRlIGlmIHNlc3Npb24gaXMgZGVsZXRlZAotLSAKMi4zNC4xCgo=
--000000000000baaaa80620a1071a--

