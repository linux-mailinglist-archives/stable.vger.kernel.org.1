Return-Path: <stable+bounces-254567-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AGozOgnfFmo9uQcAu9opvQ
	(envelope-from <stable+bounces-254567-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 14:09:45 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AA385E3DE5
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 14:09:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CBB0E301C5BA
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 12:07:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23B95302742;
	Wed, 27 May 2026 12:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="boQjcn7J"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2816C2E22B5
	for <stable@vger.kernel.org>; Wed, 27 May 2026 12:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779883595; cv=none; b=ng4vtfNXFoP8TUyZKpMu138DHh/uE7g0P8KUTaneUrJ8wnoUZcGshCnvfwSCSssJX4OxfuDWUiVCmlxv4hhl+d3ot+BDiExTs9ykiES8ZFfJ5XtpSbKM5PlGBhwwm0KguxtK5iMHufpLCBTGrYdLrDuO+ngUGteR2WLMmYKbGxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779883595; c=relaxed/simple;
	bh=xwkvGRP8dQlARoWRF+Sa7/LCxSW285YuWbnv++nskRs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WVxDQcwqfY+QZFQ771MRryt6ogm7OuTC7+o8lSB0zuLJx/YQW12tXfTPfubxz8RQlNjDkPp0iGbhdOJhnyVA9q2znpdQ5PwXYxEtBjR/HFueOv0rE49JLMzsjndP1bHZ/PGfG/2KNkMCFxhmjrS1ZtvFOQP2awU+B0BhXuzFzAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=boQjcn7J; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-49042aeeb75so67881765e9.1
        for <stable@vger.kernel.org>; Wed, 27 May 2026 05:06:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779883592; x=1780488392; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=j6sN7PF4/XgSZweTvTw4bskuyexxv8jnFzme5Pn1z5s=;
        b=boQjcn7JID6+E9l+Eas/zMQhdstfthsyJg92KwUAy/RYEaBRhBavQN12PyOTJ/9wp9
         oZhN7aJG3BThTGfgzuv2RXyEu1wDddQ2BbrRAyhhHgqtWNbHGLud4Xk0z7w5C2HSQ3DH
         BsT+xeA1vArT0xhmHj20lmxlMVYcqHysQKY+SIGFBC3g0CJNjCAeKYI4qicpwZzud3PS
         S0nR/51gjSsLGhqPOspno2vjyd2pq61u+CSIDzs+hcG9wX9OaCX9Zxp6yXwdBqZYWbzU
         bBjCV0RfT3OLhypA5SgKaEHCHSZzBEEDlv47K4L+GegBlNtzYB66qDuZGrIWHh4eLbfv
         vLaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779883592; x=1780488392;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j6sN7PF4/XgSZweTvTw4bskuyexxv8jnFzme5Pn1z5s=;
        b=gKM+UUXm/vDhnmtYAAKb/9y6tnIVIgSCT0dPdDsEB1TzvO/sCgwxYAQ82E6Ibrg9Yk
         6i+vey0xbvR2NeMDkjeRcg9cLohcntCYoMwgQnxKtV7p/KL+qW+3IYgwn/AsWqGGYjMB
         33S4uM0ltwl/xFC/EBgj2TW9gh6Wsx+hcPcFGI+MojjlNjfeAaYiFfvTo7DaMP+PpiZo
         nhEsZ/J//14d7PeooBKWaNw9NdyXwD2gfk5ME8jMP3QoxbKXpF0/h5dxNz/OMLWMIelU
         +ARLgeC97dTaGZ6MUDXOsUbC7oG6JtmZmTnNpI0BPqsPYGD6ScpZZsIWFcuaTXIuOuWR
         2wUw==
X-Forwarded-Encrypted: i=1; AFNElJ8al2a3AGhDHfRgdbDvaThfLETp/GvO/ZQvMW4rtnOmvtCp4p21H6ncX5hqfNGlKVjn7zkKnHU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0sFcfN+/j1A0BwMPyprZUXkmVv9qJT6xXZStTVVgm5620NRr7
	3cpRIdgDBuIgxLWB+4o3lUiq+jq4E94bPj72tovyy2bfS6CKIRf5jA11
X-Gm-Gg: Acq92OHHXiJwg0DmSiC0dqoFGDb15miEHSEK7er20gmhAsVqd/6IWIDEQ9n/1ZRDf1d
	pN/Arp6I0+9hnzK8ZSlGpGid74Vu5F9SSUd3hVhlmeoptC0gi1NflomV4vaA1GpqxDEdHQqUq7W
	cbRnpMi8I8m1GOUKQRtVI/iuxBf6LWf+baFI8AEjdG9r0d4rTYPbexT5iollmvtMd9wXbBiTzDw
	XSsxGj8QEcE72Ovul741Xsin6TePSfBXey95c6K2gRmWt9VQ+B2z4tYSQjUzstsJsucn4ob8CJX
	6l18xqB9R5zjWM71vrwvIXa1GkM8mYXVMvE/x34Z3Zxk0PoSK4N4hXXJ4VkR+/vGSjyp5BBpwSt
	hfXoHnWV26xaaz1eQfuWSnTn8cyAP8yVoVE+Oi3CA+rlUKpk8jYkBrRhrApiMeAs30iyXHU90eB
	nDH98MpVQjCCiTJv1vOECFHxlpPPCLNeR8EJBp0+bRlFPrliCTRshJ6CmbOevGsD5wLDhTwQ==
X-Received: by 2002:a05:600c:4f91:b0:490:6e12:5418 with SMTP id 5b1f17b1804b1-4906e12552emr162389275e9.23.1779883592073;
        Wed, 27 May 2026 05:06:32 -0700 (PDT)
Received: from eldamar.lan (c-82-192-247-196.customer.ggaweb.ch. [82.192.247.196])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490809b7619sm15849285e9.25.2026.05.27.05.06.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 05:06:30 -0700 (PDT)
Sender: Salvatore Bonaccorso <salvatore.bonaccorso@gmail.com>
Received: by eldamar.lan (Postfix, from userid 1000)
	id CD777BE2EE7; Wed, 27 May 2026 14:06:29 +0200 (CEST)
Date: Wed, 27 May 2026 14:06:29 +0200
From: Salvatore Bonaccorso <carnil@debian.org>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: manizada <manizada@pm.me>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: Please apply 3da1fdf4efbc to stable
Message-ID: <ahbeRcvu5qN55gaE@eldamar.lan>
References: <HWDVTGhsU6ON7YOl4ipsBa-4aBO4UMs2EdpPPhEyYoOWmVqbo__aVWaSuEIqescKSIxPJalwVPc2BQax8VsPmuZUXyF14lBaCyyrnu2_40g=@pm.me>
 <2026052742-discharge-smudge-6453@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2026052742-discharge-smudge-6453@gregkh>
X-Spamd-Result: default: False [-1.56 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[debian.org : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254567-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[carnil@debian.org,stable@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,pm.me:email]
X-Rspamd-Queue-Id: 1AA385E3DE5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Greg,

Not Asmin here, but saw the following.

On Wed, May 27, 2026 at 10:08:03AM +0200, Greg KH wrote:
> On Tue, May 26, 2026 at 05:08:43PM +0000, manizada wrote:
> > Hi stable team,
> > 
> > Please apply the following upstream commit to the supported stable trees:
> > 
> >   3da1fdf4efbc490041eb4f836bf596201203f8f2
> >   smb: client: reject userspace cifs.spnego descriptions
> > 
> > Reason:
> >   cifs.spnego descriptions contain authority-bearing fields consumed by
> >   cifs.upcall. This commit prevents userspace from creating trusted
> >   cifs.spnego descriptions via request_key(2)/add_key(2).
> > 
> > Requested branches:
> >   Please apply to all currently supported stable/LTS branches where it is
> >   applicable, including 7.0.y, 6.18.y, 6.12.y, 6.6.y, 6.1.y, 5.15.y, and
> >   5.10.y.
> 
> This does not apply to the 5.15.y or 5.10.y tree, please provide a
> backported version that can apply there.

There was 38c8a9a52082 ("smb: move client and server files to common
directory fs/smb") moving the files around (and which got as well
backported to the 6.1.y series). So the following should do the trick.

Regards,
Salvatore

From f89a8b4dfcdb7967b2f306b5629f7e5b92f74a26 Mon Sep 17 00:00:00 2001
From: Asim Viladi Oglu Manizada <manizada@pm.me>
Date: Sat, 16 May 2026 21:15:39 +0000
Subject: [PATCH] smb: client: reject userspace cifs.spnego descriptions

commit 3da1fdf4efbc490041eb4f836bf596201203f8f2 upstream.

cifs.spnego key descriptions contain authority-bearing fields such as
pid, uid, creduid, and upcall_target that cifs.upcall treats as
kernel-originating inputs. However, userspace can also create keys of
this type through request_key(2) or add_key(2), allowing those fields to
be supplied without CIFS origin.

Only accept cifs.spnego descriptions while CIFS is using its private
spnego_cred to request the key.

Fixes: f1d662a7d5e5 ("[CIFS] Add upcall files for cifs to use spnego/kerberos")
Assisted-by: avom-custom-harness:gpt-5.5-qwen3.6-mod-mix
Reviewed-by: David Howells <dhowells@redhat.com>
Signed-off-by: Asim Viladi Oglu Manizada <manizada@pm.me>
Signed-off-by: Steve French <stfrench@microsoft.com>
[Salvatore Bonaccorso: Apply changes to fs/cifs/cifs_spnego.c instead of
fs/smb/client/cifs_spnego.c before 38c8a9a52082 ("smb: move client and server
files to common directory fs/smb") in v6.4-rc1 and backported to v6.1.36]
Signed-off-by: Salvatore Bonaccorso <carnil@debian.org>
---
 fs/cifs/cifs_spnego.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/fs/cifs/cifs_spnego.c b/fs/cifs/cifs_spnego.c
index 4f9d08ac9dde..5b7614451033 100644
--- a/fs/cifs/cifs_spnego.c
+++ b/fs/cifs/cifs_spnego.c
@@ -20,6 +20,7 @@
  */
 
 #include <linux/list.h>
+#include <linux/cred.h>
 #include <linux/slab.h>
 #include <linux/string.h>
 #include <keys/user-type.h>
@@ -58,12 +59,27 @@ cifs_spnego_key_destroy(struct key *key)
 	kfree(key->payload.data[0]);
 }
 
+static int
+cifs_spnego_key_vet_description(const char *description)
+{
+	/*
+	 * cifs.spnego descriptions are authority-bearing inputs to cifs.upcall.
+	 * They are only valid when produced by CIFS while using the private
+	 * spnego_cred installed below.  Do not let userspace create this type
+	 * of key through request_key(2)/add_key(2), since the helper treats
+	 * pid/uid/creduid/upcall_target as kernel-originating fields.
+	 */
+	if (current_cred() != spnego_cred)
+		return -EPERM;
+	return 0;
+}
 
 /*
  * keytype for CIFS spnego keys
  */
 struct key_type cifs_spnego_key_type = {
 	.name		= "cifs.spnego",
+	.vet_description = cifs_spnego_key_vet_description,
 	.instantiate	= cifs_spnego_key_instantiate,
 	.destroy	= cifs_spnego_key_destroy,
 	.describe	= user_describe,
-- 
2.53.0

