Return-Path: <stable+bounces-70288-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3205295FF1B
	for <lists+stable@lfdr.de>; Tue, 27 Aug 2024 04:30:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5727F1C21DEC
	for <lists+stable@lfdr.de>; Tue, 27 Aug 2024 02:30:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B8B012B63;
	Tue, 27 Aug 2024 02:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="otfIQDnE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C202FD53F
	for <stable@vger.kernel.org>; Tue, 27 Aug 2024 02:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724725827; cv=none; b=PCrjX7L30ZsNUZtcr64OFkEBCXZFZSfJrgw2eW6pOHlRL4SIY013JSlgNPC4Tz8rxgRfzQYh/15tndT2pKUeJVasPR63YMUVgLxQbSlIgbuvB0G4EWYZyJSivyWtHM73RDSyj1KTskxkcrLUL0kyJ22x1LFcNVJiFmXOy8jXZzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724725827; c=relaxed/simple;
	bh=rfI58ODVTpwMfdPfL6y0X/ijnV7Bbqi+SQRBr7SzIp8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BzutNVID+G9v+8SZpA0JF8EKZxB4OsMvWeRAVZp+zHJ/ydvaAoURE4Mip9BDIIIsmoBXqbQ/Lply+ODTfCpmnL8Ek6QzoaiSzwDy7NphxnbQSpotao0ROocN00Dkbqm0WgWhy3vHwZnenQzVSjQ45Bw5leF5F2H7cCJOTI9JRLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=otfIQDnE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95819C8B7A4
	for <stable@vger.kernel.org>; Tue, 27 Aug 2024 02:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724725827;
	bh=rfI58ODVTpwMfdPfL6y0X/ijnV7Bbqi+SQRBr7SzIp8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=otfIQDnEXBxGqqnskaDNO73dM6VPkBwPO8HyNCYxjfTub+dNtWOAkRBS2aroYVNVg
	 CuTPnONW7Har76Cn1gGtd/Ia4esvItSsbhnlGY1mWdUXCQf66EEX3JT1+VJFSqKIjZ
	 1a1SOdHfIsrNrLMnTifCWN2WsqTcrU0SeOomG65WpxSAeK6o+miAWaa2CZL0Psuyuv
	 mKFBVl/kN1QDlFyAd4PlAAkVvFNd+APGBhpYG9nYmhRAj8nLFZXK3V4n6LLPvJbFF9
	 SwRZu+walhChZWQar21obni9z7o90FKMzlWJpA6Euu2rwfMDXfdkwbKugNG4XcV+A5
	 uXSvtgGkAFaKQ==
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-270596dbf59so3655672fac.3
        for <stable@vger.kernel.org>; Mon, 26 Aug 2024 19:30:27 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV0th6nlAKU3EDJttuiXKUKkPiYUWbn5tdrlGvhU3MZZStofZ2uIxA7xqJwGEifDtYzeZs7GdQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2wRADSnbshsoes3v/7bMy5/CmyGXqAXH73y2lDlf7QPm6Ybw2
	aMLUvSTgRnJyZtjRiuEeEBkb7WTNdQTAivGswk1tiR9VtSjHZCh6K1guF1Cv9Q7mpmcfCpSiyzd
	piRI6qAxLt8CWlf04sgXTyVYidK4=
X-Google-Smtp-Source: AGHT+IG89S4zqUI5XBmLmF8DrGc+6Eyk6jI/1kbuwNACGGHu8Yvg1aqxRPzMxCLBAlJUUWF+uMmUW1GGLRI/Kyg8Tu0=
X-Received: by 2002:a05:6871:8aa:b0:25d:efdb:ae23 with SMTP id
 586e51a60fabf-273e6552611mr13673310fac.27.1724725826920; Mon, 26 Aug 2024
 19:30:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2024082626-succulent-engraver-73cd@gregkh>
In-Reply-To: <2024082626-succulent-engraver-73cd@gregkh>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Tue, 27 Aug 2024 11:30:15 +0900
X-Gmail-Original-Message-ID: <CAKYAXd_j19G31-3TAC0gBiDtgWentYpRAA9oc_wZ0T+Q6s3T0w@mail.gmail.com>
Message-ID: <CAKYAXd_j19G31-3TAC0gBiDtgWentYpRAA9oc_wZ0T+Q6s3T0w@mail.gmail.com>
Subject: Re: FAILED: patch "[PATCH] ksmbd: fix race condition between
 destroy_previous_session()" failed to apply to 6.6-stable tree
To: gregkh@linuxfoundation.org
Cc: stfrench@microsoft.com, stable@vger.kernel.org
Content-Type: multipart/mixed; boundary="0000000000003feb0d0620a106f6"

--0000000000003feb0d0620a106f6
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 26, 2024 at 8:57=E2=80=AFPM <gregkh@linuxfoundation.org> wrote:
>
>
Hi Greg,

> The patch below does not apply to the 6.6-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.
Could you please apply the attached backport patch for linux 6.6 stable ker=
nel ?

Thanks!



>
> To reproduce the conflict and resubmit, you may use the following command=
s:
>
> git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.gi=
t/ linux-6.6.y
> git checkout FETCH_HEAD
> git cherry-pick -x 76e98a158b207771a6c9a0de0a60522a446a3447
> # <resolve conflicts, build, test, etc.>
> git commit -s
> git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024082626-=
succulent-engraver-73cd@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..
>
> Possible dependencies:
>
> 76e98a158b20 ("ksmbd: fix race condition between destroy_previous_session=
() and smb2 operations()")
> d484d621d40f ("ksmbd: add durable scavenger timer")
> c8efcc786146 ("ksmbd: add support for durable handles v1/v2")
> fa9415d4024f ("ksmbd: mark SMB2_SESSION_EXPIRED to session when destroyin=
g previous session")
> c2a721eead71 ("ksmbd: lazy v2 lease break on smb2_write()")
> d47d9886aeef ("ksmbd: send v2 lease break notification for directory")
> eb547407f357 ("ksmbd: downgrade RWH lease caching state to RH for directo=
ry")
> 2e450920d58b ("ksmbd: move oplock handling after unlock parent dir")
> 4274a9dc6aeb ("ksmbd: separately allocate ci per dentry")
> 864fb5d37163 ("ksmbd: fix possible deadlock in smb2_open")
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

--0000000000003feb0d0620a106f6
Content-Type: application/x-patch; 
	name="0001-ksmbd-fix-race-condition-between-destroy_previous_se.patch"
Content-Disposition: attachment; 
	filename="0001-ksmbd-fix-race-condition-between-destroy_previous_se.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_m0bt08id0>
X-Attachment-Id: f_m0bt08id0

RnJvbSA5ZTBhM2QzOWEzNmY4MGZkMzliNWVjMmY5NDNiOTUxNGJiYTFlOWJkIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBOYW1qYWUgSmVvbiA8bGlua2luamVvbkBrZXJuZWwub3JnPgpE
YXRlOiBUdWUsIDI3IEF1ZyAyMDI0IDA5OjI3OjU2ICswOTAwClN1YmplY3Q6IFtQQVRDSCBsaW51
eC02LjYueSBdIGtzbWJkOiBmaXggcmFjZSBjb25kaXRpb24gYmV0d2VlbiBkZXN0cm95X3ByZXZp
b3VzX3Nlc3Npb24oKQogYW5kIHNtYjIgb3BlcmF0aW9ucygpCgpbIFVwc3RyZWFtIGNvbW1pdCA3
NmU5OGExNThiMjA3NzcxYTZjOWEwZGUwYTYwNTIyYTQ0NmEzNDQ3IF0KCklmIHRoZXJlIGlzIC0+
UHJldmlvdXNTZXNzaW9uSWQgZmllbGQgaW4gdGhlIHNlc3Npb24gc2V0dXAgcmVxdWVzdCwKVGhl
IHNlc3Npb24gb2YgdGhlIHByZXZpb3VzIGNvbm5lY3Rpb24gc2hvdWxkIGJlIGRlc3Ryb3llZC4K
RHVyaW5nIHRoaXMsIGlmIHRoZSBzbWIyIG9wZXJhdGlvbiByZXF1ZXN0cyBpbiB0aGUgcHJldmlv
dXMgc2Vzc2lvbiBhcmUKYmVpbmcgcHJvY2Vzc2VkLCBhIHJhY3kgaXNzdWUgY291bGQgaGFwcGVu
IHdpdGgga3NtYmRfZGVzdHJveV9maWxlX3RhYmxlKCkuClRoaXMgcGF0Y2ggc2V0cyBjb25uLT5z
dGF0dXMgdG8gS1NNQkRfU0VTU19ORUVEX1JFQ09OTkVDVCB0byBibG9jawppbmNvbWluZyAgb3Bl
cmF0aW9ucyBhbmQgd2FpdHMgdW50aWwgb24tZ29pbmcgb3BlcmF0aW9ucyBhcmUgY29tcGxldGUK
KGkuZS4gaWRsZSkgYmVmb3JlIGRlc2N0b3J5aW5nIHRoZSBwcmV2aW91cyBzZXNzaW9uLgoKRml4
ZXM6IGM4ZWZjYzc4NjE0NiAoImtzbWJkOiBhZGQgc3VwcG9ydCBmb3IgZHVyYWJsZSBoYW5kbGVz
IHYxL3YyIikKQ2M6IHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmcgIyB2Ni42KwpSZXBvcnRlZC1ieTog
emRpLWRpc2Nsb3N1cmVzQHRyZW5kbWljcm8uY29tICMgWkRJLUNBTi0yNTA0MApTaWduZWQtb2Zm
LWJ5OiBOYW1qYWUgSmVvbiA8bGlua2luamVvbkBrZXJuZWwub3JnPgpTaWduZWQtb2ZmLWJ5OiBT
dGV2ZSBGcmVuY2ggPHN0ZnJlbmNoQG1pY3Jvc29mdC5jb20+Ci0tLQogZnMvc21iL3NlcnZlci9j
b25uZWN0aW9uLmMgICAgICAgIHwgMzQgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLQog
ZnMvc21iL3NlcnZlci9jb25uZWN0aW9uLmggICAgICAgIHwgIDMgKystCiBmcy9zbWIvc2VydmVy
L21nbXQvdXNlcl9zZXNzaW9uLmMgfCAgOCArKysrKysrKwogZnMvc21iL3NlcnZlci9zbWIycGR1
LmMgICAgICAgICAgIHwgIDIgKy0KIDQgZmlsZXMgY2hhbmdlZCwgNDQgaW5zZXJ0aW9ucygrKSwg
MyBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9mcy9zbWIvc2VydmVyL2Nvbm5lY3Rpb24uYyBi
L2ZzL3NtYi9zZXJ2ZXIvY29ubmVjdGlvbi5jCmluZGV4IDA5ZTFlNzc3MTU5Mi4uNzg4OWRmODEx
MmI0IDEwMDY0NAotLS0gYS9mcy9zbWIvc2VydmVyL2Nvbm5lY3Rpb24uYworKysgYi9mcy9zbWIv
c2VydmVyL2Nvbm5lY3Rpb24uYwpAQCAtMTY1LDExICsxNjUsNDMgQEAgdm9pZCBrc21iZF9hbGxf
Y29ubl9zZXRfc3RhdHVzKHU2NCBzZXNzX2lkLCB1MzIgc3RhdHVzKQogCXVwX3JlYWQoJmNvbm5f
bGlzdF9sb2NrKTsKIH0KIAotdm9pZCBrc21iZF9jb25uX3dhaXRfaWRsZShzdHJ1Y3Qga3NtYmRf
Y29ubiAqY29ubiwgdTY0IHNlc3NfaWQpCit2b2lkIGtzbWJkX2Nvbm5fd2FpdF9pZGxlKHN0cnVj
dCBrc21iZF9jb25uICpjb25uKQogewogCXdhaXRfZXZlbnQoY29ubi0+cmVxX3J1bm5pbmdfcSwg
YXRvbWljX3JlYWQoJmNvbm4tPnJlcV9ydW5uaW5nKSA8IDIpOwogfQogCitpbnQga3NtYmRfY29u
bl93YWl0X2lkbGVfc2Vzc19pZChzdHJ1Y3Qga3NtYmRfY29ubiAqY3Vycl9jb25uLCB1NjQgc2Vz
c19pZCkKK3sKKwlzdHJ1Y3Qga3NtYmRfY29ubiAqY29ubjsKKwlpbnQgcmMsIHJldHJ5X2NvdW50
ID0gMCwgbWF4X3RpbWVvdXQgPSAxMjA7CisJaW50IHJjb3VudCA9IDE7CisKK3JldHJ5X2lkbGU6
CisJaWYgKHJldHJ5X2NvdW50ID49IG1heF90aW1lb3V0KQorCQlyZXR1cm4gLUVJTzsKKworCWRv
d25fcmVhZCgmY29ubl9saXN0X2xvY2spOworCWxpc3RfZm9yX2VhY2hfZW50cnkoY29ubiwgJmNv
bm5fbGlzdCwgY29ubnNfbGlzdCkgeworCQlpZiAoY29ubi0+YmluZGluZyB8fCB4YV9sb2FkKCZj
b25uLT5zZXNzaW9ucywgc2Vzc19pZCkpIHsKKwkJCWlmIChjb25uID09IGN1cnJfY29ubikKKwkJ
CQlyY291bnQgPSAyOworCQkJaWYgKGF0b21pY19yZWFkKCZjb25uLT5yZXFfcnVubmluZykgPj0g
cmNvdW50KSB7CisJCQkJcmMgPSB3YWl0X2V2ZW50X3RpbWVvdXQoY29ubi0+cmVxX3J1bm5pbmdf
cSwKKwkJCQkJYXRvbWljX3JlYWQoJmNvbm4tPnJlcV9ydW5uaW5nKSA8IHJjb3VudCwKKwkJCQkJ
SFopOworCQkJCWlmICghcmMpIHsKKwkJCQkJdXBfcmVhZCgmY29ubl9saXN0X2xvY2spOworCQkJ
CQlyZXRyeV9jb3VudCsrOworCQkJCQlnb3RvIHJldHJ5X2lkbGU7CisJCQkJfQorCQkJfQorCQl9
CisJfQorCXVwX3JlYWQoJmNvbm5fbGlzdF9sb2NrKTsKKworCXJldHVybiAwOworfQorCiBpbnQg
a3NtYmRfY29ubl93cml0ZShzdHJ1Y3Qga3NtYmRfd29yayAqd29yaykKIHsKIAlzdHJ1Y3Qga3Nt
YmRfY29ubiAqY29ubiA9IHdvcmstPmNvbm47CmRpZmYgLS1naXQgYS9mcy9zbWIvc2VydmVyL2Nv
bm5lY3Rpb24uaCBiL2ZzL3NtYi9zZXJ2ZXIvY29ubmVjdGlvbi5oCmluZGV4IDBlMDRjZjhiMWQ4
OS4uYjkzZTU0Mzc3OTNlIDEwMDY0NAotLS0gYS9mcy9zbWIvc2VydmVyL2Nvbm5lY3Rpb24uaAor
KysgYi9mcy9zbWIvc2VydmVyL2Nvbm5lY3Rpb24uaApAQCAtMTQ1LDcgKzE0NSw4IEBAIGV4dGVy
biBzdHJ1Y3QgbGlzdF9oZWFkIGNvbm5fbGlzdDsKIGV4dGVybiBzdHJ1Y3Qgcndfc2VtYXBob3Jl
IGNvbm5fbGlzdF9sb2NrOwogCiBib29sIGtzbWJkX2Nvbm5fYWxpdmUoc3RydWN0IGtzbWJkX2Nv
bm4gKmNvbm4pOwotdm9pZCBrc21iZF9jb25uX3dhaXRfaWRsZShzdHJ1Y3Qga3NtYmRfY29ubiAq
Y29ubiwgdTY0IHNlc3NfaWQpOwordm9pZCBrc21iZF9jb25uX3dhaXRfaWRsZShzdHJ1Y3Qga3Nt
YmRfY29ubiAqY29ubik7CitpbnQga3NtYmRfY29ubl93YWl0X2lkbGVfc2Vzc19pZChzdHJ1Y3Qg
a3NtYmRfY29ubiAqY3Vycl9jb25uLCB1NjQgc2Vzc19pZCk7CiBzdHJ1Y3Qga3NtYmRfY29ubiAq
a3NtYmRfY29ubl9hbGxvYyh2b2lkKTsKIHZvaWQga3NtYmRfY29ubl9mcmVlKHN0cnVjdCBrc21i
ZF9jb25uICpjb25uKTsKIGJvb2wga3NtYmRfY29ubl9sb29rdXBfZGlhbGVjdChzdHJ1Y3Qga3Nt
YmRfY29ubiAqYyk7CmRpZmYgLS1naXQgYS9mcy9zbWIvc2VydmVyL21nbXQvdXNlcl9zZXNzaW9u
LmMgYi9mcy9zbWIvc2VydmVyL21nbXQvdXNlcl9zZXNzaW9uLmMKaW5kZXggYWVjMGE3YTEyNDA1
Li5kYWM1Zjk4NGYxNzUgMTAwNjQ0Ci0tLSBhL2ZzL3NtYi9zZXJ2ZXIvbWdtdC91c2VyX3Nlc3Np
b24uYworKysgYi9mcy9zbWIvc2VydmVyL21nbXQvdXNlcl9zZXNzaW9uLmMKQEAgLTMxMCw2ICsz
MTAsNyBAQCB2b2lkIGRlc3Ryb3lfcHJldmlvdXNfc2Vzc2lvbihzdHJ1Y3Qga3NtYmRfY29ubiAq
Y29ubiwKIHsKIAlzdHJ1Y3Qga3NtYmRfc2Vzc2lvbiAqcHJldl9zZXNzOwogCXN0cnVjdCBrc21i
ZF91c2VyICpwcmV2X3VzZXI7CisJaW50IGVycjsKIAogCWRvd25fd3JpdGUoJnNlc3Npb25zX3Rh
YmxlX2xvY2spOwogCWRvd25fd3JpdGUoJmNvbm4tPnNlc3Npb25fbG9jayk7CkBAIC0zMjQsOCAr
MzI1LDE1IEBAIHZvaWQgZGVzdHJveV9wcmV2aW91c19zZXNzaW9uKHN0cnVjdCBrc21iZF9jb25u
ICpjb25uLAogCSAgICBtZW1jbXAodXNlci0+cGFzc2tleSwgcHJldl91c2VyLT5wYXNza2V5LCB1
c2VyLT5wYXNza2V5X3N6KSkKIAkJZ290byBvdXQ7CiAKKwlrc21iZF9hbGxfY29ubl9zZXRfc3Rh
dHVzKGlkLCBLU01CRF9TRVNTX05FRURfUkVDT05ORUNUKTsKKwllcnIgPSBrc21iZF9jb25uX3dh
aXRfaWRsZV9zZXNzX2lkKGNvbm4sIGlkKTsKKwlpZiAoZXJyKSB7CisJCWtzbWJkX2FsbF9jb25u
X3NldF9zdGF0dXMoaWQsIEtTTUJEX1NFU1NfTkVFRF9ORUdPVElBVEUpOworCQlnb3RvIG91dDsK
Kwl9CiAJa3NtYmRfZGVzdHJveV9maWxlX3RhYmxlKCZwcmV2X3Nlc3MtPmZpbGVfdGFibGUpOwog
CXByZXZfc2Vzcy0+c3RhdGUgPSBTTUIyX1NFU1NJT05fRVhQSVJFRDsKKwlrc21iZF9hbGxfY29u
bl9zZXRfc3RhdHVzKGlkLCBLU01CRF9TRVNTX05FRURfTkVHT1RJQVRFKTsKIG91dDoKIAl1cF93
cml0ZSgmY29ubi0+c2Vzc2lvbl9sb2NrKTsKIAl1cF93cml0ZSgmc2Vzc2lvbnNfdGFibGVfbG9j
ayk7CmRpZmYgLS1naXQgYS9mcy9zbWIvc2VydmVyL3NtYjJwZHUuYyBiL2ZzL3NtYi9zZXJ2ZXIv
c21iMnBkdS5jCmluZGV4IDU5MmEyY2RmZDA2Ny4uNDUzN2VhOGZkM2U1IDEwMDY0NAotLS0gYS9m
cy9zbWIvc2VydmVyL3NtYjJwZHUuYworKysgYi9mcy9zbWIvc2VydmVyL3NtYjJwZHUuYwpAQCAt
MjIxMCw3ICsyMjEwLDcgQEAgaW50IHNtYjJfc2Vzc2lvbl9sb2dvZmYoc3RydWN0IGtzbWJkX3dv
cmsgKndvcmspCiAJa3NtYmRfY29ubl91bmxvY2soY29ubik7CiAKIAlrc21iZF9jbG9zZV9zZXNz
aW9uX2Zkcyh3b3JrKTsKLQlrc21iZF9jb25uX3dhaXRfaWRsZShjb25uLCBzZXNzX2lkKTsKKwlr
c21iZF9jb25uX3dhaXRfaWRsZShjb25uKTsKIAogCS8qCiAJICogUmUtbG9va3VwIHNlc3Npb24g
dG8gdmFsaWRhdGUgaWYgc2Vzc2lvbiBpcyBkZWxldGVkCi0tIAoyLjM0LjEKCg==
--0000000000003feb0d0620a106f6--

