Return-Path: <stable+bounces-224628-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gPs1JlTOsGkKnQIAu9opvQ
	(envelope-from <stable+bounces-224628-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 03:07:16 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E509325A9E8
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 03:07:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A067031B73EB
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 02:06:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE3E613FEE;
	Wed, 11 Mar 2026 02:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="JZFdoL+V"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CA2933A715
	for <stable@vger.kernel.org>; Wed, 11 Mar 2026 02:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773194792; cv=none; b=qjoekTIdnXcQxnDVrorn1ebBY8C5j7c+y5ykzcgIbfbJ5Ja1uBWXCaPHSagdoEKmLlYXvdMIbE1RCtJMS6k/0zLvFVyIn2zcqaHk2vamgKKuAf5gH1Ai1PG84kHMMEPeKNpC121By5cBXKr1lMB3w25qVD28NBFANU+65thYFjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773194792; c=relaxed/simple;
	bh=P1+ZQrw/a3+oxXwntvE4BjS3zMiSxriGuhAOi6EH3nU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uCwcIfN/qJD/IpVjx3JM/oMU/eppY8PqtqwSE+RvWBTzXFycAHOtHjgTKfnXYtDOE+zmF2qHPeiMdoHdmaTpfwXq+qJe7utegYNENYCBs70Eup7Ilh6nMZD6gcElSXs2vYgLedKnapRrqVOCv81/gvjQii8FDM33et6GFj93CcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=JZFdoL+V; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4852a8482fcso40675635e9.3
        for <stable@vger.kernel.org>; Tue, 10 Mar 2026 19:06:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1773194789; x=1773799589; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YeasIl4NlVlSUO2J1WHrJ04QPxBi9mp/dFx8NjgnjNI=;
        b=JZFdoL+Vzw8c9AOUjOyLJZhGgJuPJN3+xfi5pXlNgByhuvT2jrIq/nK5wUhuEh95UP
         0mEqIHMcQS+8SqVC1K/Z2H9bBz/mHDaan9sEkjD/n/+KHLrOdyxv8hyg3hj+snvKGVfo
         dnkC/sa0HFle9ntFHcYgqYGY3/cF0owqHjBJp4Ra3HJX0zMsR9aPn9kZQSo0u1SF1RdZ
         DXaPMB2KxEDhwvCSGc9P+yppQkxDcDnIcM9qQ5w+xLZiPed4NAde1VumNl/UDMzhurrX
         c/hVWN70nb7eMfT3le7BdkxvAUugL/fgHBActcXOYhE7LqntKq8hPkqPWhXQxr70eC5O
         3ZHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773194789; x=1773799589;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YeasIl4NlVlSUO2J1WHrJ04QPxBi9mp/dFx8NjgnjNI=;
        b=F8jOkmZwW+zxz3XT8bKvvlMlSa5g3KzmKX1/60Px8V4+fryQ9+1AF8RhV1nuLfpScc
         qtPlOI8QK42mJVwQWLPvXsJ522reFz+hprwpmyPH+WstIKDlDJ8vNXwEJkLE/0oQxWlP
         pEOlxxxv6kSADmNLDCxgEMG77LvBN6IoDdlwOnmMMo70UefzRHLFIuxpBj00rAY1HM4h
         PY2lh0BF0zMPCbPyDfSllVjL6KXMsbk/qTPPJIcWOe4muZu2WRxqybeFUB9wi/iLqnwr
         LdUrpfi3xslr//R3ssdJjBverP121i/xgkDCkT+c9uM5LFKBlDdAqM8E/S6kLxxpeEXp
         AVAA==
X-Forwarded-Encrypted: i=1; AJvYcCVQzHWR2REqwkYBW7hRbihexwgYTkwc53omW34h76AoJLXDhOqgxacJqWwHzI1Lr/Q7aFDynXQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmDFNamdVWUifcdBUwfm7F/xP836uuWwzxOzRlghufERghTAF4
	kbqWQq6N7pZfpTphmifhItDf25s7iLSg2kBhLDa/1qucgZ3wpeATVQq+y6OaZUp+FZE=
X-Gm-Gg: ATEYQzzHwTa1fdP2AdcFqCTjSTgH/C/T2fDIvwko3AHLerCTbF3xpX7jL4+GZLOH4Bw
	gFvkdZDoBUGBuSQXvn3/SzksgT0MEo+TLUFVbdh1St9D2QmLBb4QhfaKDbnsiiUWI2hG1xpzIAc
	ogakTy/s3HjELQiLS2+smKwYcmlslRPvzqHK2CywrlLMEF+3hZyO26AtylCFggt3bnIu0MXVwVn
	G85UlmeboUsEYDRzaVRJS7Agu+DC6DxQIHq8lb6XJShh0+cO9owQ6jL8nWYEvnEmQSIGhCRGwCR
	a6OsJuSD8w0VNYyxvUMrVR8ySb5qSEfmenoPNA1MxjkT/IZGKrw0LgT+Moea5PehOakuGnfTRxr
	9Lgya+XADn9+yZEkbAOA1wY3nGO0ovBpRCWRyyidcdxpVF+0P74SY04kAY5XLBOb8RePZyySTY0
	tgMLU1O7GL+fGLObXTpiNYWRryUjRRTYv2bmjGjIN0RKBEeU3TZcxUJuA=
X-Received: by 2002:a05:600c:a46:b0:485:3026:2b8b with SMTP id 5b1f17b1804b1-4854b12bfd2mr12821085e9.29.1773194789451;
        Tue, 10 Mar 2026 19:06:29 -0700 (PDT)
Received: from precision.tail0b5424.ts.net ([2804:7f0:6402:b103:6a0a:3e1c:778a:5cc7])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2be8aa7413esm728571eec.24.2026.03.10.19.06.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 19:06:28 -0700 (PDT)
Date: Tue, 10 Mar 2026 23:06:24 -0300
From: Henrique Carvalho <henrique.carvalho@suse.com>
To: "Dr. Thomas Orgis" <thomas.orgis@uni-hamburg.de>
Cc: Steve French <sfrench@samba.org>, linux-cifs@vger.kernel.org, 
	regressions@lists.linux.dev, stable@vger.kernel.org
Subject: Re: [REGRESSION] failure to reconnect on SMB server restart with
 custom TCP port (not 445): Host is down (at least since 6.6.95)
Message-ID: <c66p7dr6vlujvnwczbnrmqx7monkdgdnm4rwewm76aibn7jza3@d3uik74dei72>
References: <20260310235642.6d9798f4@plasteblaster>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="vyyfnoz5o32eea4w"
Content-Disposition: inline
In-Reply-To: <20260310235642.6d9798f4@plasteblaster>
X-Rspamd-Queue-Id: E509325A9E8
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain,text/x-patch];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-224628-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	HAS_ATTACHMENT(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:+];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,suse.com:dkim,suse.com:email,archlinux.org:url]
X-Rspamd-Action: no action


--vyyfnoz5o32eea4w
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 10, 2026 at 11:56:42PM +0100, Dr. Thomas Orgis wrote:
> Dear Linux-CIFS maintainer(s),
> 
> I stumbled upon a regression in the Linux cifs/smb3 client when working
> with a smbd using a non-standard port. I am not the first to note this, see
> 
> 	https://bbs.archlinux.org/viewtopic.php?id=306712
> 
> which is a report from mid last year, indicating the problem sometime
> after Linux 6.6.72. It is a very simple issue, where details of the
> kernel builds or mount setup don't seem to matter much: Older kernels
> reconnect to a SMB server that was restarted (old processes killed and
> replaced), newer kernels do not and just have a defunct mount.
> 
> I reproduced this in our HPC cluster environment with such smb.conf on
> the server side
> 
> [global]
> security = user
> map to guest = Bad Password
> server role = standalone server
> smb ports = 1445
> 
> [public]
> path = /some/path
> guest ok = yes
> read only = yes
> 
> and such a mount command on the client:
> 
> mount -t smb3 -o port=1445,user=guest,password=foo //server/public dir
> 
> When I kill and re-start smbd on the server, older client kernels
> reconnect and continue to return listings and files from the share,
> while newer kernels give this:
> 

My suspicion is that the regression was introduced by:

    5713127da855 ("cifs: update dstaddr whenever channel iface is updated")

That change causes parse_server_interfaces() -- should this be running
without multichannel mount option? -- to overwrite the port stored in
server->dstaddr with CIFS_PORT.

The attached patch preserves the existing port from server->dstaddr.

Note that I have not yet tested this patch or confirmed the regression
with a bisect. If you can't, I will try to do that tomorrow.

-- 
Henrique
SUSE Labs

--vyyfnoz5o32eea4w
Content-Type: text/x-patch; charset=us-ascii
Content-Disposition: attachment; filename="patch.patch"

From 1218840331eef3a6b523ad39e851a412f570b7d8 Mon Sep 17 00:00:00 2001
From: Henrique Carvalho <henrique.carvalho@suse.com>
Date: Tue, 10 Mar 2026 22:52:52 -0300
Subject: [PATCH] smb: client: preserve destination port when parsing server
 interfaces

parse_server_interfaces() initializes interface socket addresses with
CIFS_PORT. When the mount uses a non-default port this overwrites the
configured destination port.

Later, cifs_chan_update_iface() copies this sockaddr into server->dstaddr,
causing reconnect attempts to use the wrong port after server interface
updates.

Use the existing port from server->dstaddr instead.

Fixes: 5713127da855 ("cifs: update dstaddr whenever channel iface is updated")
Signed-off-by: Henrique Carvalho <henrique.carvalho@suse.com>
---
 fs/smb/client/smb2ops.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/fs/smb/client/smb2ops.c b/fs/smb/client/smb2ops.c
index 7f2d3459cbf9..d3cbfb3fdfc9 100644
--- a/fs/smb/client/smb2ops.c
+++ b/fs/smb/client/smb2ops.c
@@ -628,6 +628,7 @@ parse_server_interfaces(struct network_interface_info_ioctl_rsp *buf,
 	struct smb_sockaddr_in6 *p6;
 	struct cifs_server_iface *info = NULL, *iface = NULL, *niface = NULL;
 	struct cifs_server_iface tmp_iface;
+	__be16 port;
 	ssize_t bytes_left;
 	size_t next = 0;
 	int nb_iface = 0;
@@ -676,18 +677,20 @@ parse_server_interfaces(struct network_interface_info_ioctl_rsp *buf,
 		 * conversion explicit in case either one changes.
 		 */
 		case INTERNETWORK:
+			port = ((struct sockaddr_in *)&ses->server->dstaddr)->sin_port;
 			addr4 = (struct sockaddr_in *)&tmp_iface.sockaddr;
 			p4 = (struct smb_sockaddr_in *)p->Buffer;
 			addr4->sin_family = AF_INET;
 			memcpy(&addr4->sin_addr, &p4->IPv4Address, 4);
 
 			/* [MS-SMB2] 2.2.32.5.1.1 Clients MUST ignore these */
-			addr4->sin_port = cpu_to_be16(CIFS_PORT);
+			addr4->sin_port = port;
 
 			cifs_dbg(FYI, "%s: ipv4 %pI4\n", __func__,
 				 &addr4->sin_addr);
 			break;
 		case INTERNETWORKV6:
+			port = ((struct sockaddr_in6 *)&ses->server->dstaddr)->sin6_port;
 			addr6 =	(struct sockaddr_in6 *)&tmp_iface.sockaddr;
 			p6 = (struct smb_sockaddr_in6 *)p->Buffer;
 			addr6->sin6_family = AF_INET6;
@@ -696,7 +699,7 @@ parse_server_interfaces(struct network_interface_info_ioctl_rsp *buf,
 			/* [MS-SMB2] 2.2.32.5.1.2 Clients MUST ignore these */
 			addr6->sin6_flowinfo = 0;
 			addr6->sin6_scope_id = 0;
-			addr6->sin6_port = cpu_to_be16(CIFS_PORT);
+			addr6->sin6_port = port;
 
 			cifs_dbg(FYI, "%s: ipv6 %pI6\n", __func__,
 				 &addr6->sin6_addr);
-- 
2.52.0


--vyyfnoz5o32eea4w--

