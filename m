Return-Path: <stable+bounces-237843-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GP9kOIUt3mnxogkAu9opvQ
	(envelope-from <stable+bounces-237843-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 14:05:25 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A3253F9C66
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 14:05:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 06305307170A
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 12:02:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C77D346ACE;
	Tue, 14 Apr 2026 12:02:02 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from outboundhk.mxmail.xiaomi.com (outboundhk.mxmail.xiaomi.com [118.143.206.90])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 870F23E0C7C
	for <stable@vger.kernel.org>; Tue, 14 Apr 2026 12:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=118.143.206.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776168122; cv=none; b=GetTZMMRVkTmzcHDpU7WDTiQfXiLEdATtiYzOiMHVW++Wf9g2x9f3y80ixbT2iJBdCEx//nzWd4gdCRwaJPFm2oP4xH51p1vuXH0pgN0Ml+2r0tqzShz+Ul6YQYryn7pDWzn1XTtxZPx475vfFEmLiRpQJbEzFWpCGs/vPhZXwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776168122; c=relaxed/simple;
	bh=6o1+bTIpGHTw7bkmfAkAG1sdQDF9myb5dXUiMp5dlWQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Ur2I9Si+HraUTU2P+hDa34JrDwJCO/g8C0b9RoRiR0SPwmqRoqAI0KLWvqfSA1eHCs3auC5JnHpZTIVgsH8RhspcqhSQE7TcebYTgDyN0ZNVWzLsQirSlakqjKle8PiglzUboAM/7l3B5mgPFyHiEacCa5BSP+61Vj9U7jF67xU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=xiaomi.com; spf=pass smtp.mailfrom=xiaomi.com; arc=none smtp.client-ip=118.143.206.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=xiaomi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiaomi.com
X-CSE-ConnectionGUID: 0MtM43o0S6udRLdDGVct7A==
X-CSE-MsgGUID: aHslSGohSYmetzvcMVsOFA==
X-IronPort-AV: E=Sophos;i="6.23,179,1770566400"; 
   d="scan'208";a="146599931"
From: Ziqing Chen <chenziqing@xiaomi.com>
To: <chzq96@163.com>
CC: Ziqing Chen <chenziqing@xiaomi.com>, <stable@vger.kernel.org>
Subject: [PATCH] ALSA: control: Validate buf_len before strnlen() in snd_ctl_elem_init_enum_names()
Date: Tue, 14 Apr 2026 20:01:34 +0800
Message-ID: <20260414120134.212833-1-chenziqing@xiaomi.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: BJ-MBX04.mioffice.cn (10.237.8.124) To BJ-MBX03.mioffice.cn
 (10.237.8.123)
X-Spamd-Result: default: False [1.54 / 15.00];
	DMARC_POLICY_QUARANTINE(1.50)[xiaomi.com : SPF not aligned (relaxed), No valid DKIM,quarantine];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-237843-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_TO(0.00)[163.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chenziqing@xiaomi.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.961];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[xiaomi.com:email,xiaomi.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7A3253F9C66
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

snd_ctl_elem_init_enum_names() advances pointer p through the names
buffer while decrementing buf_len. If buf_len reaches zero but items
remain, the next iteration calls strnlen(p, 0).

While strnlen(p, 0) returns 0 and would hit the existing name_len =3D=3D 0
error path, CONFIG_FORTIFY_SOURCE's fortified strnlen() first checks
maxlen against __builtin_dynamic_object_size(). When Clang loses track
of p's object size inside the loop, this triggers a BRK exception panic
before the return value is examined.

Add a buf_len =3D=3D 0 guard at the loop entry to prevent calling fortified
strnlen() on an exhausted buffer.

Found by kernel fuzz testing through Xiaomi Smartphone.

Fixes: 8d448162bda5 ("ALSA: control: add support for ENUMERATED user space =
controls")
Cc: stable@vger.kernel.org
Signed-off-by: Ziqing Chen <chenziqing@xiaomi.com>
---
 sound/core/control.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sound/core/control.c b/sound/core/control.c
index 0ddade871b52..6ceb5f977fcd 100644
--- a/sound/core/control.c
+++ b/sound/core/control.c
@@ -1574,6 +1574,10 @@ static int snd_ctl_elem_init_enum_names(struct user_=
element *ue)
        /* check that there are enough valid names */
        p =3D names;
        for (i =3D 0; i < ue->info.value.enumerated.items; ++i) {
+               if (buf_len =3D=3D 0) {
+                       kvfree(names);
+                       return -EINVAL;
+               }
                name_len =3D strnlen(p, buf_len);
                if (name_len =3D=3D 0 || name_len >=3D 64 || name_len =3D=
=3D buf_len) {
                        kvfree(names);
--
2.52.0

#/******=B1=BE=D3=CA=BC=FE=BC=B0=C6=E4=B8=BD=BC=FE=BA=AC=D3=D0=D0=A1=C3=D7=
=B9=AB=CB=BE=B5=C4=B1=A3=C3=DC=D0=C5=CF=A2=A3=AC=BD=F6=CF=DE=D3=DA=B7=A2=CB=
=CD=B8=F8=C9=CF=C3=E6=B5=D8=D6=B7=D6=D0=C1=D0=B3=F6=B5=C4=B8=F6=C8=CB=BB=F2=
=C8=BA=D7=E9=A1=A3=BD=FB=D6=B9=C8=CE=BA=CE=C6=E4=CB=FB=C8=CB=D2=D4=C8=CE=BA=
=CE=D0=CE=CA=BD=CA=B9=D3=C3=A3=A8=B0=FC=C0=A8=B5=AB=B2=BB=CF=DE=D3=DA=C8=AB=
=B2=BF=BB=F2=B2=BF=B7=D6=B5=D8=D0=B9=C2=B6=A1=A2=B8=B4=D6=C6=A1=A2=BB=F2=C9=
=A2=B7=A2=A3=A9=B1=BE=D3=CA=BC=FE=D6=D0=B5=C4=D0=C5=CF=A2=A1=A3=C8=E7=B9=FB=
=C4=FA=B4=ED=CA=D5=C1=CB=B1=BE=D3=CA=BC=FE=A3=AC=C7=EB=C4=FA=C1=A2=BC=B4=B5=
=E7=BB=B0=BB=F2=D3=CA=BC=FE=CD=A8=D6=AA=B7=A2=BC=FE=C8=CB=B2=A2=C9=BE=B3=FD=
=B1=BE=D3=CA=BC=FE=A3=A1 This e-mail and its attachments contain confidenti=
al information from XIAOMI, which is intended only for the person or entity=
 whose address is listed above. Any use of the information contained herein=
 in any way (including, but not limited to, total or partial disclosure, re=
production, or dissemination) by persons other than the intended recipient(=
s) is prohibited. If you receive this e-mail in error, please notify the se=
nder by phone or email immediately and delete it!******/#

