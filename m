Return-Path: <stable+bounces-219855-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UG69EHWooGnilQQAu9opvQ
	(envelope-from <stable+bounces-219855-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 26 Feb 2026 21:09:25 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B1B701AEDDB
	for <lists+stable@lfdr.de>; Thu, 26 Feb 2026 21:09:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A54F13012BE8
	for <lists+stable@lfdr.de>; Thu, 26 Feb 2026 20:09:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA43F45349B;
	Thu, 26 Feb 2026 20:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=venev.name header.i=@venev.name header.b="UytnPd9e"
X-Original-To: stable@vger.kernel.org
Received: from a1-bg02.venev.name (a1-bg02.venev.name [213.240.239.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D866C368964;
	Thu, 26 Feb 2026 20:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.240.239.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772136562; cv=none; b=FTCORbe3Bvp8qRIdVIn7V/GQG/ZJvH9mqr2VJVnR4MyB9R7hTM+VOsUyQj3iCphyNwCSgpeyDBOjc2m5dqeYfOeNwSJvwpyK2Jph+y1T4fpQjzwQ/A8g9Dk8z1KwtpCgJ4Tw88kVXnQdNKTr7Ij32zo9oFtayOnqU30qPwwns0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772136562; c=relaxed/simple;
	bh=nBSy1LovVwxyrlD8UpAllqMlA6RwAoMmp6BfHrshVVw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HOAZRoyZ8TdGvr0VxGn/IeENJLfb1gT2PP7a/DVoccLV7cajHozJzNXBzoEVK4B2aWQbnao65Stc8P8OF/FtuhONPp+y9xxoCmxDRAhUC/cPC8JTo95hNJsD+9IlbLiaSALQtsHo7nOpK6LVXmGd147SwHOgxUPQlowKmMQ0Bfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=venev.name; spf=pass smtp.mailfrom=venev.name; dkim=pass (4096-bit key) header.d=venev.name header.i=@venev.name header.b=UytnPd9e; arc=none smtp.client-ip=213.240.239.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=venev.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=venev.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=venev.name;
	s=default; h=Content-Transfer-Encoding:Content-Type:Date:To:From:Subject:
	Message-ID:Reply-To:Sender; bh=mYtPKyqwIlJVBSgoG1JcsrSrVbRIZLx025OtxUJHIdc=; 
	b=UytnPd9eJQPzfMIfWnsa/vjiCbMwE6tSlQ9QqbsAaW6NX6/2bplXCYias3eTHUD7mGO5oDM9HDJ
	PQMpVFPnKebibEyWCUSp6MsJFyQaN8frmWri/1gTh+H5JZyYvoM01yBkLxWGoyxEkiNSS6ixfWFkL
	ESm0bmbxrmlDZ8GFCVbsWp0kZ3gmQN9RQ9IbExegfmeh9oWk5g5+A1i+lKbUQ5n8TcUce8E3Nx5w/
	WKnWLkqhSbmcwoKkV268V/3yLDwFTZ90eULr68529UYyOinH9I+bp/5Kb/QJGdtm3vJhnbFRzW8jj
	VDxBp7xzhiPHFd6zWCzl7uR0v7z59LvnLiKktfx28NIA3qE/c24S4OlZnV/BFAos3XbwhEuW13egd
	DIPCnG/qU5ZeZ5wtGoxrD9JsqLtHbAgF5kRmpwEHW5lP0raWeHJeMcVLDUtfn4UlCFZDZC94YmMMf
	jfftx6ye9TZf++QaUrzEsNoNYxu0iMlxcFbcDFdhLRa5jpdIMj6tQ4/11qolY5O3YucC2IXsTx6ED
	vkOfCr6UtbyXiYiQxBuGErnG4aGguRQiYIYxKbF1P9MYG0u8drRMkPiOkRxgbWF4xlevkBnxnYYMN
	Z6e7HaPyc3lpxa2c6Hi969+Ni5LkSQwAXq0vmZ7/yIvlZj6V8SvsydMTz/H10JHUdHsgU=;
Received: from a1-bg02.venev.name ([213.240.239.49] helo=pmx1.venev.name)
	by a1-bg02.venev.name with esmtps
	id 1vvhfZ-0000000AdVb-05uV
	(TLS1.3:TLS_AES_256_GCM_SHA384:256)
	(envelope-from <hristo@venev.name>);
	Thu, 26 Feb 2026 20:09:09 +0000
Received: from box.m.venev.name ([213.240.239.49])
	by pmx1.venev.name with ESMTPSA
	id 3yftAGWooGnsriYAdB6GMg
	(envelope-from <hristo@venev.name>); Thu, 26 Feb 2026 20:09:09 +0000
Message-ID: <e714d8106a492077707cd31df96401a08caef6fe.camel@venev.name>
Subject: Re:  [PATCH] ceph: Do not skip the first folio of the next object
 in writeback
From: Hristo Venev <hristo@venev.name>
To: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
Cc: "stable@vger.kernel.org" <stable@vger.kernel.org>, Alex Markuze	
 <amarkuze@redhat.com>, "ceph-devel@vger.kernel.org"
 <ceph-devel@vger.kernel.org>,  "slava@dubeyko.com"	 <slava@dubeyko.com>,
 "idryomov@gmail.com" <idryomov@gmail.com>
Date: Thu, 26 Feb 2026 22:09:08 +0200
In-Reply-To: <c1c033c44edf8d20b0a9dd8944a2f21bec942c1e.camel@ibm.com>
References: <20260225170758.2014172-1-hristo@venev.name>
						 <50447e5d0d4e3bf993d05dc9da9dde1c20371378.camel@ibm.com>
					 <4c074e71fd58851a84596c4798b9378a3006d551.camel@venev.name>
				 <1d321c24a2c4045e8bd79922a94fb4264a40f7de.camel@ibm.com>
			 <daf3f64ab55d5c6e6c4bf612db609e5505795d05.camel@ibm.com>
		 <b7c3c502da0d135fe1d57014f9f1074f8a2d4ceb.camel@venev.name>
	 <c1c033c44edf8d20b0a9dd8944a2f21bec942c1e.camel@ibm.com>
Autocrypt: addr=hristo@venev.name; prefer-encrypt=mutual;
 keydata=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
 AjQ6o01lu
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[venev.name,quarantine];
	R_DKIM_ALLOW(-0.20)[venev.name:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,redhat.com,dubeyko.com,gmail.com];
	TAGGED_FROM(0.00)[bounces-219855-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[venev.name:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hristo@venev.name,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[box:email,venev.name:mid,venev.name:dkim,venev.name:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B1B701AEDDB
X-Rspamd-Action: no action

On Thu, 2026-02-26 at 19:55 +0000, Viacheslav Dubeyko wrote:
> Are you capable to execute successfully this sequence?
>=20
> b4 am
> https://lore.kernel.org/ceph-devel/20260225170758.2014172-1-hristo@venev.=
name/T/#u
> git am
> 20260225_hristo_ceph_do_not_skip_the_first_folio_of_the_next_object_i
> n_writeback
> .mbx

It applies for me on v7.0-rc1:


hristo@box ~/sw/linux $ git checkout v7.0-rc1
HEAD is now at 6de23f81a5e08 Linux 7.0-rc1
hristo@box ~/sw/linux $ b4 am 'https://lore.kernel.org/ceph-devel/202602251=
70758.2014172-1-hristo@venev.name/T/#u'
Analyzing 7 messages in the thread
Analyzing 0 code-review messages
Checking attestation on all messages, may take a moment...
---
  =E2=9C=93 [PATCH] ceph: Do not skip the first folio of the next object in=
 writeback
  ---
  =E2=9C=93 Signed: DKIM/venev.name
---
Total patches: 1
---
 Link: https://lore.kernel.org/r/20260225170758.2014172-1-hristo@venev.name
 Base: applies clean to current tree
       git checkout -b 20260225_hristo_venev_name HEAD
       git am ./20260225_hristo_ceph_do_not_skip_the_first_folio_of_the_nex=
t_object_in_writeback.mbx
hristo@box ~/sw/linux $ git am ./20260225_hristo_ceph_do_not_skip_the_first=
_folio_of_the_next_object_in_writeback.mbx
Applying: ceph: Do not skip the first folio of the next object in writeback
hristo@box ~/sw/linux $ git show | head
commit 14f494cefd0a49abf41d455b4c3a30d78ba1f91b
Author: Hristo Venev <hristo@venev.name>
Date:   Wed Feb 25 19:07:56 2026 +0200

    ceph: Do not skip the first folio of the next object in writeback
   =20
    When `ceph_process_folio_batch` encounters a folio past the end of the
    current object, it should leave it in the batch so that it is picked up
    in the next iteration.
   =20
hristo@box ~/sw/linux $ sha256sum ./20260225_hristo_ceph_do_not_skip_the_fi=
rst_folio_of_the_next_object_in_writeback.mbx=20
a623e1f8f06000efd86b078114ba41c4f079b5c140cdc8342e6993bb9d299851  ./2026022=
5_hristo_ceph_do_not_skip_the_first_folio_of_the_next_object_in_writeback.m=
bx

> Potentially, I could have some issue on my side.
>=20
> Thanks,
> Slava.

