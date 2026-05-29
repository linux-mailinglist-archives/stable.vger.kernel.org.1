Return-Path: <stable+bounces-256560-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aK20Ie1TGWqYvAgAu9opvQ
	(envelope-from <stable+bounces-256560-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 10:53:01 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 12DEB5FF88A
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 10:53:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D4D4A30B1713
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 08:49:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8D563C5856;
	Fri, 29 May 2026 08:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="NfyfhhCN"
X-Original-To: stable@vger.kernel.org
Received: from mail-43167.protonmail.ch (mail-43167.protonmail.ch [185.70.43.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ADC83C342D;
	Fri, 29 May 2026 08:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780044479; cv=none; b=XNhPCJmy5Nzq/S7i71vEoGgn5klZ1HYt2yr/aDmsmvB4d2/5AzKD52gFO9A1HoVmovLuKeo+vRH2LyOUmB0LoipbNoCwfuD0RmuXgMuvffiEn5c+pF3jACwkrazj18NSuy34YHxsoIYw3RDunz6JKdjcxN8JDzWJvwQTVtoHNBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780044479; c=relaxed/simple;
	bh=W9s804aaCSx5H9gDlvD/aSggzOZ3rPWZ02B7QkmI4q4=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=jf+mR7rhBSSZ2XnfAm+LkxeCVHf1kmjybouV2ZpIHV9O8tPsewmdhRiEXKQNoRzNR+azUzExY9LFEIF1BzBJY5M+fJBJW87skdaLBOF/XZe977zKAK5bCz6rQbpJz3gKmyVqIwOb9c8DQmTjd5NEc4NQTJN++rw7qmdx2UuPL18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=NfyfhhCN; arc=none smtp.client-ip=185.70.43.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1780044466; x=1780303666;
	bh=HGveVO6NXZm5Ifp8gtHAkmpAgoi9AAEtOnKI/6I9s/U=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=NfyfhhCNlJzQMovCiUiQ87iQhZLOkOEJkE+FJKbjWma30eqSqnDo+UaCuQkGepF+S
	 UaV8U25JXdFWZ7I82y+Ld1rJq639CcrKWCmLZkLFMNmJ45UZOGJNF/MgQVfSC8Exkw
	 kbvpBPJJqXF4G+lM2kgjshWrd4y0J/LZXMVp7xjMVbXwugAs1y4QtrRrQCN5ChGqax
	 mQ/vzXrc/dglA8xuEdvukOKdzWfa+3d9hvPxWo+zP5F/Rr2Mv8bs668Xx7wbB9rHPV
	 1O9a8wQMxAU6WBzmEn0diXvZy53Uj8vb18uc4trmFVrxCxkkHtMwNDaj4dpKI7SfTp
	 +kHAcRCtJmOmw==
Date: Fri, 29 May 2026 00:37:24 +0000
To: "idryomov@gmail.com" <idryomov@gmail.com>
From: hexlabsecurity@proton.me
Cc: Xiubo Li <xiubli@redhat.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>, "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: [PATCH v2] ceph: fix pre-auth out-of-bounds read in ceph_handle_caps snap-trace
Message-ID: <UsWw5IfDWpwh15ADMj-qoaghJUm2jpu8VYPdvJN7kJjwW5fzpXj9trnbKMLA_NZV9gHzYD3cgOtx92fH8a_Zs17zySW2OW2DppNXPBMB0hQ=@proton.me>
Feedback-ID: 199661219:user:proton
X-Pm-Message-ID: 22901c09991c50bcf9797bd40ef29c951bf9dc4a
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[proton.me,quarantine];
	R_DKIM_ALLOW(-0.20)[proton.me:s=protonmail];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-256560-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hexlabsecurity@proton.me,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[proton.me:+];
	TAGGED_RCPT(0.00)[stable];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,proton.me:email,proton.me:mid,proton.me:dkim]
X-Rspamd-Queue-Id: 12DEB5FF88A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From fc1939cc8994118b05b057aff34e0c50b4a39760 Mon Sep 17 00:00:00 2001
From: Bryam Vargas <hexlabsecurity@proton.me>
Date: Thu, 28 May 2026 18:29:28 -0500
Subject: [PATCH v2] ceph: fix pre-auth out-of-bounds read in ceph_handle_ca=
ps
 snap-trace

ceph_handle_caps() reads snap_trace_len from the wire-format
ceph_mds_caps header and uses it unconditionally to build a fake
end pointer (snaptrace + snaptrace_len) that is later handed to
ceph_update_snap_trace() in the CEPH_CAP_OP_IMPORT case:

    snaptrace     =3D h + 1;
    snaptrace_len =3D le32_to_cpu(h->snap_trace_len);
    p             =3D snaptrace + snaptrace_len;
    ...
    case CEPH_CAP_OP_IMPORT:
        if (snaptrace_len) {
            ...
            if (ceph_update_snap_trace(mdsc, snaptrace,
                                       snaptrace + snaptrace_len,
                                       false, &realm)) { ... }

ceph_update_snap_trace() then decodes a struct ceph_mds_snap_realm
from snaptrace using ceph_decode_need(&p, e, sizeof(*ri), bad)
with the attacker-supplied fake end e =3D=3D snaptrace + snaptrace_len.
With snaptrace_len =3D=3D 0xFFFFFFFF the bound check is trivially
satisfied, ri =3D p reads sizeof(struct ceph_mds_snap_realm) past
the legitimate msg->front buffer, and ri->num_snaps /
ri->num_prior_parent_snaps then drive further out-of-bounds
reads of the encoded snap arrays.

The eleven msg_version >=3D 2 .. msg_version >=3D 12 decoder blocks
above the op switch each catch this OOB through their
ceph_decode_*_safe() / ceph_decode_need() helpers, but they sit
behind a hdr.version-gated if, so a malicious or compromised
MDS that sets msg->hdr.version =3D 1 reaches the IMPORT path with
no version-gated decoder having validated snap_trace_len. The
shape has been present since ceph_handle_caps() was introduced.

Validate snap_trace_len against the message front buffer before
consuming it, using the canonical ceph_decode_need() / ceph_has_room()
helper.  The helper bounds the length with subtraction (n <=3D end - p,
guarded by end >=3D p) rather than pointer addition, so it is wrap-safe
for the attacker-controlled u32 length on 32-bit builds where
p + snap_trace_len could overflow the address space.  This matches the
rest of the ceph decode path (e.g. the pool_ns_len check a few lines
below), and the existing goto bad cleanup already covers this exit
path.

Reported-by: Bryam Vargas <hexlabsecurity@proton.me>
Fixes: a8599bd821d0 ("ceph: capability management")
Cc: stable@vger.kernel.org
Signed-off-by: Bryam Vargas <hexlabsecurity@proton.me>
Reviewed-by: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
---
v2: use the ceph_decode_need() helper instead of the open-coded
    subtraction check, per review (Viacheslav Dubeyko); keeps the
    bound wrap-safe and consistent with the surrounding decoders.
    No functional change vs v1 on 64-bit (v1 used the open-coded
    "snaptrace_len > end - snaptrace").

 fs/ceph/caps.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
index d51454e995a8..68435a4d6fa9 100644
--- a/fs/ceph/caps.c
+++ b/fs/ceph/caps.c
@@ -4365,6 +4365,7 @@ void ceph_handle_caps(struct ceph_mds_session *sessio=
n,
=20
 =09snaptrace =3D h + 1;
 =09snaptrace_len =3D le32_to_cpu(h->snap_trace_len);
+=09ceph_decode_need(&snaptrace, end, snaptrace_len, bad);
 =09p =3D snaptrace + snaptrace_len;
=20
 =09if (msg_version >=3D 2) {
--=20
2.43.0

