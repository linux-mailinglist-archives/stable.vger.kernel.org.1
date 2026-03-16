Return-Path: <stable+bounces-225603-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oPfMHe8muGnhZgEAu9opvQ
	(envelope-from <stable+bounces-225603-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 16:51:11 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E408F29CC5C
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 16:51:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EA750300767B
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 15:49:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 464863A5E87;
	Mon, 16 Mar 2026 15:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="eorOX1nP"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 050383A4532
	for <stable@vger.kernel.org>; Mon, 16 Mar 2026 15:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773676150; cv=none; b=c5a8ESgXQvbfZ6uDAa99+JG5S0amkVDvY5hQCcYQ7gg/cxxtjrbF1zaRGrd2lAxt29VhtEGvLEpV8ONbA+8QPXwWSaaH/DW8ScvysJLHL2jV52FMd/OmHGp0AvKTByPSx3+IGTxttpe/BAfL75EH1xx4G9SMMSOKbLHZgEtNbSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773676150; c=relaxed/simple;
	bh=Dh7+4dYkoUTolSxtP0+/CTh6ZhfJ28yseiX8+sYEy5I=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=I2FoewUTwcn36sVOOrA2b6r79FRk6Rp80v4jUx60vwdKlw687Tihw5Tk5KZUpgvohbBNDaVbAbQYWUiEgG3JuVkTQwSu0IDyed4zggffXhaO2K+fzfk/OAYPlLTmTz7V1ZEQUpbJ1QyCatEWUIFVjsiZmeUZ+pWDdloCziOiDMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=eorOX1nP; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4852a9c6309so38684625e9.0
        for <stable@vger.kernel.org>; Mon, 16 Mar 2026 08:49:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1773676146; x=1774280946; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lwwDgcyrhQFPGtIVQQIcEl/sTMG9NYkgRg8ru3+yAMU=;
        b=eorOX1nP3PXbhX39A0n+5w+d+NZgUhEIznxjjWXhlRYELYsXL+Q0ufd9fhn8MsLJJK
         YHS565iyt7PsIw7nqxISAu7eZrN2GKIm34AXy+sF1xk3RKeOAr6WVTGgFc/W/XooSNvi
         zvjfecPUsvGRpq1Ni85a+bHqp7sA/uzSGhC+OuxFbFyZaY+CPJYams8KeIFz/LuYh18G
         zP3KHzk7yWnm9h8EdTCEdkBSVbgsMZqx5youUw1+i+f67nz9KzMILEsy7J7nNcp+Lt+Y
         zYqQCn9dxdgt27yOVdc7B4s9slUYFaAr4+JJbH+s78Ql3t0rlbkhBsWwhXgj3BNhLlFN
         JfkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773676146; x=1774280946;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lwwDgcyrhQFPGtIVQQIcEl/sTMG9NYkgRg8ru3+yAMU=;
        b=Y+cHneBglXRfXNoEAAA24CfTYmfn0oVVxoKRuXsXZuof3bAlKVNqq4F+O9cGCRwWC+
         nch97C/l8vSO9YvUYFA9qUExFzmC67umAU0bOEIYjkpmtBzQaAe2dS21RjJXHsVxKl3/
         WkKUAMpX+Kc1xKZ+CVpKSk14jp+UFMjwPcRNh9+ZUDlhrNMAN9BS3IPdVSWF2UMnfHu3
         vAs1LsHc2gCdqjkPFpvele0G4/agT4dFhGKAcTQeGieINl5yNHkdjOtvmnJtaKJhecDF
         Gi6w4CImetVBmM6pd5k1LOTOAdccMHKMeZU5YX0c7eOGGuBIeO9TYRIfwNHI4SUfT8nT
         1fug==
X-Gm-Message-State: AOJu0YylYN0DWtKDLLZIdbkAqwzXAoxx+xEOk//bY0VB/eY+6+uy4j4Y
	VR2dl5AuZBKnxc12ZBLqHhzX75wWdWwAZBRDMumu8YCkPsyb9CLlSo/hCAyoUVeZYRmn+ivcnV+
	OCIBC
X-Gm-Gg: ATEYQzwyMgFGkd7NVG0oVo6MYWyUs7qRPPf3oPn52Y5Yb16ECW3Xx+WNXtyYPUuX0Gp
	kAvRlloWJ4JLxBsoPJlIZCgbgl7zKQRnRx5DmLOsK9Pxipx0dF9pObOnJ0Mg+EykaHcF+0FCNuM
	hdaRw2XE88c9hd7ltKD4t5tlO1xiAF6zq0PVuM9+PjBqztEN/GcEu5y88AtPc3bD59lr7hs9Hvn
	wXrL+QsD2JRUR20iBo4dNL0wGA2Ve378EEosCfKKtOs+Nr13Niuk8iRIAa0lahM4hk6JNIWYcto
	FWqELxWMroGv/0N2PPVP3mhVpxaaO5U4+BdezpJzXyMItEW/IeAohGVz9oaugi7deLmqQtuFSyH
	Bt/9GALZqi8duqMrDadWJ+/AWcmwGp3KdOAJDh/e1QmDvpqln8TU5XPxmBl2hJa2M0tyowyWhkL
	eqUDgKZCL7o0LCbL0mEoyThrX9R78WltMt/gsvK6GXairb3P9XBVDq8eM=
X-Received: by 2002:a05:600c:8486:b0:485:4136:99a8 with SMTP id 5b1f17b1804b1-48556700ca5mr224691885e9.22.1773676146089;
        Mon, 16 Mar 2026 08:49:06 -0700 (PDT)
Received: from precision.tail0b5424.ts.net ([2804:7f0:6402:b103:6a0a:3e1c:778a:5cc7])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-128f62b01eesm14212346c88.7.2026.03.16.08.49.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 08:49:05 -0700 (PDT)
Date: Mon, 16 Mar 2026 12:49:00 -0300
From: Henrique Carvalho <henrique.carvalho@suse.com>
To: stable@vger.kernel.org
Cc: linux-cifs@vger.kernel.org, Steve French <smfrench@gmail.com>, 
	thorsten.blum@linux.dev, pc@manguebit.org
Subject: stable: [PATCH] smb: client: Don't log plaintext credentials in
 cifs_set_cifscreds
Message-ID: <eijo3pknvy4gl2xh23by7kjdxpoc27an3dqfmfttremp4xb53o@z2kq34l2onvy>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-225603-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,linux.dev,manguebit.org];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[henrique.carvalho@suse.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,talpey.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,manguebit.org:email,samba.org:email,linux.dev:email]
X-Rspamd-Queue-Id: E408F29CC5C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

I believe the following commit may have been missed for the relevant
stable branches.

2f37dc436d4e ("smb: client: Don't log plaintext credentials in cifs_set_cifscreds")

Could you please consider backporting it?

Thanks!

-- 
Henrique
SUSE Labs

----- Forwarded message from Thorsten Blum <thorsten.blum@linux.dev> -----

Date: Thu, 26 Feb 2026 22:28:45 +0100
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Steve French <sfrench@samba.org>, Paulo Alcantara <pc@manguebit.org>,
  Ronnie Sahlberg <ronniesahlberg@gmail.com>, Shyam Prasad N
 <sprasad@microsoft.com>,  Tom Talpey <tom@talpey.com>, Bharath SM
 <bharathsm@microsoft.com>,  Jeff Layton <jlayton@kernel.org>
Cc: Thorsten Blum <thorsten.blum@linux.dev>, stable@vger.kernel.org,  Steve
 French <smfrench@gmail.com>, linux-cifs@vger.kernel.org,
 samba-technical@lists.samba.org,  linux-kernel@vger.kernel.org
Subject: [PATCH] smb: client: Don't log plaintext credentials in
 cifs_set_cifscreds
Message-ID: <20260226212845.784172-2-thorsten.blum@linux.dev>

When debug logging is enabled, cifs_set_cifscreds() logs the key
payload and exposes the plaintext username and password. Remove the
debug log to avoid exposing credentials.

Fixes: 8a8798a5ff90 ("cifs: fetch credentials out of keyring for non-krb5 auth multiuser mounts")
Cc: stable@vger.kernel.org
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 fs/smb/client/connect.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/smb/client/connect.c b/fs/smb/client/connect.c
index 33dfe116ca52..038f87062419 100644
--- a/fs/smb/client/connect.c
+++ b/fs/smb/client/connect.c
@@ -2236,7 +2236,6 @@ cifs_set_cifscreds(struct smb3_fs_context *ctx, struct cifs_ses *ses)
 	/* find first : in payload */
 	payload = upayload->data;
 	delim = strnchr(payload, upayload->datalen, ':');
-	cifs_dbg(FYI, "payload=%s\n", payload);
 	if (!delim) {
 		cifs_dbg(FYI, "Unable to find ':' in payload (datalen=%d)\n",
 			 upayload->datalen);
-- 
Thorsten Blum <thorsten.blum@linux.dev>
GPG: 1D60 735E 8AEF 3BE4 73B6  9D84 7336 78FD 8DFE EAD4



----- End forwarded message -----

