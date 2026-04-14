Return-Path: <stable+bounces-237866-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kPhmH2g73mnipgkAu9opvQ
	(envelope-from <stable+bounces-237866-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 15:04:40 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1748F3FA47F
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 15:04:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 23819301C5FA
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 13:04:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF0BA3E6DD0;
	Tue, 14 Apr 2026 13:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C9aVets9"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E7791F2380
	for <stable@vger.kernel.org>; Tue, 14 Apr 2026 13:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776171860; cv=none; b=Pa2KYW/qTKhH4JlKvXwFXyZtXBwPB8XBS4I8wbWFyUVm71j6gikUNoZXNCa7y9jRZVKbwp+mxz2maEYEx+5cOTdlZO5J3/oZZex74oHpt3xOuntXS4UvpItkcsFUpk4Uk8HzHwra/8EZGq8Y2z/YDryywX/ME8UHx9I4uLGcad4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776171860; c=relaxed/simple;
	bh=4/AER0+79jUWl6FaRfWd3aGY/aJ6MEcGm48BpGjFB+k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q20F/E0Vb6I+QJVIGabg8VK50mmk7b+fVEZWYy/doQBXVD7kicO1H+Uop4PdMW8KIFEE6Es7MbHy9FfGP8+QnOvRn578G6JLUAeLWDREiyJl0Xkn4chZrRg3VKIHciSiCZbQyLmaBjOQULl/Ch3VrESu66Lej1FCtWmLHS9PXiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C9aVets9; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2ab08e6c553so5655335ad.3
        for <stable@vger.kernel.org>; Tue, 14 Apr 2026 06:04:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776171859; x=1776776659; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=opcylBd2GGN1SyilCKpA4V3rg0BLKqf3938q77JOvpk=;
        b=C9aVets9yeSzJe9hZrf9sflWrbgaQDVXGBVkHRK4icRXkXC04qXsI6dSoFwVLqQYuT
         7ZWEcH0DQNUsDbeusJxX90smZZIBFq8yQur4Az364q5KUSrGmLpL2ZA65+RjlCoh40z1
         sfNToR4EGSxF8jlRc7x8be6y4MGqoYswm4RUdImfPkrfeNQO/QrLbLjOLzzbjEKKioYl
         7xic3EY/Pk6Lb8RTuirLJcRr1Z21Ji/xaeSoB74lTXR7p2bU/jOS6psQ8j6apm5uOBcT
         NffVGuxH6Cx5+VMmTxvkxnWKkDq7uHXqQT2G3YlDEt/gtp9XnmhKZxzZtIJLnfCCMmFy
         XcLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776171859; x=1776776659;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=opcylBd2GGN1SyilCKpA4V3rg0BLKqf3938q77JOvpk=;
        b=haboWpFSwmNXV6KkbV1yW1cufltPpD0QFW0rGMZXTNH/rQME+AjwrN7oj6CPTD6Zj5
         Kx/Ot9FtIJp7dBIENInGEw9Y52ggwtnGZXauHQzxQL8NEnClU5gPBIvgPxYh6nIGKNz/
         TiJXZaaPnrnH8ug1Ud5l/kT9Mj/2obxS5ZKTZiiLTvia5y9x+ViTKAAhJz1sirutYHtI
         O5V8x9UcoYKG5XTPSUoTdjpjOunFRx+i9VeNYmVXj9ECJoUJ27tN3jbdXVceKoy9Y6uF
         yhen0zAVsN93VQ0zagujFEB9TJR3jejw82ZG9b52ymcCXYy+J1R6J7NmS8TOdw30Y//c
         WSNQ==
X-Forwarded-Encrypted: i=1; AFNElJ9lkQzAa3au2GGxx4qJT1R1NtcTfQMsSlN3KEUMU7AeUZaww2K3LYrZegOmVDfYEG47JsBZTCE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKJFqeFqNm4hs2DcM9qVa9znGVsiMM0o4tFxfKQszF/60o65IL
	5K4fU6TCcIGceFQTuqDU/Wt1SNikGnDRMClTgDgC0FN9LdMm3xzuXb4Y
X-Gm-Gg: AeBDietiLeU1eXUK9/n4EegUDTLDup9L0FlqYMSo2Lxp4U4amyr6KdXqL8UfuMpRnrS
	dEaUxI/H7A82O0JbBxfGYfkeLM2kZ3OZBvLNB+dlOJ91bf9LHGFpjL00zTRjEsUFA9/pNIUc7cb
	AwBQsHKb5V7PdL59keNOOZOx5uCu+305IZuDGuI6+1bsHdjCsCa9KgAJfwo42L8pSB6As7MlN5J
	LZvYsiXo12kSjqLsS2BBHgKZAg9mSNZnA49JEgNE3a/+F7GQZsB5MVtl3J601KFwgjNfXeXu8Fa
	XCGXHlCGtnfj7IgIcNOMzakxJuwHrjQCBz7ZzdVf+HVx9PA7VJ4M+kvq17R9OEd4UBeR9cPS4tn
	vqyM/0kXMkhnGJH+8xXm4vtdlEzyL7JcScsfyQYCWHwdFkp7O9ka0hzrGt6MfXiU8ZDvB4o1XVr
	hr4pb+o7khjl8EDSWgwwMRrHX8rtRKLhC/PICgKE3YalUtYxPLDtCGL13w0RzwsPj2aWm9eXU=
X-Received: by 2002:a17:902:b213:b0:2b2:aa7b:b3bd with SMTP id d9443c01a7336-2b2d5a6e4famr76571835ad.6.1776171858706;
        Tue, 14 Apr 2026 06:04:18 -0700 (PDT)
Received: from mi-HP-ProDesk-680-G6-PCI-Microtower-PC ([43.224.245.229])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b45d066afesm70522445ad.8.2026.04.14.06.04.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 06:04:18 -0700 (PDT)
From: Ziqing Chen <chzq96@gmail.com>
X-Google-Original-From: Ziqing Chen <chenziqing@xiaomi.com>
To: tiwai@suse.com,
	perex@perex.cz
Cc: linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Ziqing Chen <chenziqing@xiaomi.com>
Subject: [RESEND PATCH] ALSA: control: Validate buf_len before strnlen() in snd_ctl_elem_init_enum_names()
Date: Tue, 14 Apr 2026 21:03:33 +0800
Message-ID: <20260414130333.244544-1-chenziqing@xiaomi.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <87ik9tsukj.wl-tiwai@suse.de>
References: <87ik9tsukj.wl-tiwai@suse.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-237866-lists,stable=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chzq96@gmail.com,stable@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,xiaomi.com:email,xiaomi.com:mid]
X-Rspamd-Queue-Id: 1748F3FA47F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

snd_ctl_elem_init_enum_names() advances pointer p through the names
buffer while decrementing buf_len. If buf_len reaches zero but items
remain, the next iteration calls strnlen(p, 0).

While strnlen(p, 0) returns 0 and would hit the existing name_len == 0
error path, CONFIG_FORTIFY_SOURCE's fortified strnlen() first checks
maxlen against __builtin_dynamic_object_size(). When Clang loses track
of p's object size inside the loop, this triggers a BRK exception panic
before the return value is examined.

Add a buf_len == 0 guard at the loop entry to prevent calling fortified
strnlen() on an exhausted buffer.

Found by kernel fuzz testing through Xiaomi Smartphone.

Fixes: 8d448162bda5 ("ALSA: control: add support for ENUMERATED user space controls")
Cc: stable@vger.kernel.org
Signed-off-by: Ziqing Chen <chenziqing@xiaomi.com>
---
 sound/core/control.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sound/core/control.c b/sound/core/control.c
index 0ddade871b52..6ceb5f977fcd 100644
--- a/sound/core/control.c
+++ b/sound/core/control.c
@@ -1574,6 +1574,10 @@ static int snd_ctl_elem_init_enum_names(struct user_element *ue)
 	/* check that there are enough valid names */
 	p = names;
 	for (i = 0; i < ue->info.value.enumerated.items; ++i) {
+		if (buf_len == 0) {
+			kvfree(names);
+			return -EINVAL;
+		}
 		name_len = strnlen(p, buf_len);
 		if (name_len == 0 || name_len >= 64 || name_len == buf_len) {
 			kvfree(names);
-- 
2.52.0


