Return-Path: <stable+bounces-250024-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cCHsCd3oDWrr4gUAu9opvQ
	(envelope-from <stable+bounces-250024-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 19:01:17 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A1693592D07
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 19:01:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 91DAE33F42AE
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 16:05:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 937A8349AE6;
	Wed, 20 May 2026 16:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MMRi5Gwr"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34E65277C88
	for <stable@vger.kernel.org>; Wed, 20 May 2026 16:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779293124; cv=pass; b=TrdaJzXaw+mII/QSGuchVYYqxtW2+YqMk0Y/VxI/yylhNxAQxtJKRRYw+8Q1MDLMilql/QljBwL2I9ZkXU47bQXmCguJCVlJ1F581KNP/Y65KzHRNHQevcYJmDmQ5fidOVIgSfVISdFXuPDPgV3TCgkvCJDJKB2cdySibNnDBuQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779293124; c=relaxed/simple;
	bh=2EDlKael8RTaQN7c5fkMhXdnQq8CX837PJmCWXpE4tw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P60nj6ezjl+GSQAtBYKxF5kJ6NDM6LToNDoEowwJd85hQJNPMR+e++Yn4oHyM2aJjleHhrDzKl9uN3JJDKeHWPx2QELm3bB4h/b9MhtcTfmyFtNZR+oX998rBBVQO0y/XTTiO3VcruWNkLJ4p+NTGsvrsGf47SPHG5c0S/4Vkw0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MMRi5Gwr; arc=pass smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3664df32e91so5439926a91.3
        for <stable@vger.kernel.org>; Wed, 20 May 2026 09:05:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779293122; cv=none;
        d=google.com; s=arc-20240605;
        b=jETGkxsyZj2d87Bs3nuwoanFI2xdLveqEY2O5oCFQiB+6AASpYMMOijC9kPEPu79so
         hsCV2R2uNbjoVACwGeKVwy3+LaWk/Vu64r8gWsiQVq69nwSPmHb1W9Xur7RvnM66MbfN
         A1kLXGknrS0LXRurTHF4ell3TsVRgqcctFmsLHgek2k0wtUH8YRR+WlQM10UqrhhqLDt
         gD22tVmzidlWpHdLLPQnIMsOHI/gGEio2xOW7ouI9Gxzqy5LNZMqLZkOp49SJuvrVAdJ
         VZY/OPQCe+GGanCaZRJ/NwbfgnZy04nkbFe2vPVhTCy4wwWFVzcjYkyTXanNmwj/oHXq
         ivFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=ZzZEO9R9MG/Y+UDP0CkIZv8Ywq/jQNn3Y29wLwYcdyc=;
        fh=CJI7dbYiXRUKsM5rK3H33xoyRbjkc8h5uS8vmqkmVYc=;
        b=dYGZF5R93FB1iSUf0a6LhW9mx3kv03kmPuIu09H6WGfYZM8vppg1vrtOqht2HrJE+T
         jxFFg1/54AEsMlPWW2gAO2/7Okd+I/BmIZnKv9a98V0ZVJLcdAfnfrI439H9cFW4M+5T
         Yni+OT61N/DGtvFi31MAG7sLBFCRzbSV6GNd0Q7sxSrSSI/kEVKwn3sttRLAAKuVd99p
         3cyvsKkVXHqby3hzFn4M+uR0q7emo72OKRb5sVLjV9gKYlXq/1GxMRh3PpUHJGSLmvkN
         exr67B6HdgTjAgWa9leUlq+c5GuSlVYOMpFkw22XfBQNjtEKAahP8iAS/pk2lU3dUlzr
         ZtHA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779293122; x=1779897922; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZzZEO9R9MG/Y+UDP0CkIZv8Ywq/jQNn3Y29wLwYcdyc=;
        b=MMRi5GwrWhzLs/hp568pTV01vjZdW19UD0e0SDzCOwap//3eciYWnocNMjlQx9W9sS
         jvZ0Y1ExkherY27Ai5rat6HM1thtJv7vRKYDpsfbE6DTRLaLMog2bYDAbOvd4F+yx3nK
         wW94ys+S9cEG0acZA1JAvi9u4zzgpvpw/I66ob/wOk1OmsTCC0rNwwAqSlbKXX1AQmEO
         eoOfoD8oHMrevj+s+8tADqsOUAq4sVR0N8I8j+nQ8aUpnf+0KLAfn712XaWRhr67rDwz
         s/2tyexjpWwAUHYbu1yBga60tLwi8+DzuXe4qsO7GZqFijInfoV0JAZ302Vh2/tceOOl
         HYjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779293122; x=1779897922;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZzZEO9R9MG/Y+UDP0CkIZv8Ywq/jQNn3Y29wLwYcdyc=;
        b=H0b8IRukCnFhFxZBB4tU1klv+KBsos+To5DA+qzWn755eRrsQrTI1HSSH3IX7LPkS5
         3GsUFzBKa4O9yc1vqwaLNYDKia8+BXf4PIyq/vHcOJm7pb5lncnuWc5klcmTK0p3yBfJ
         hZ8jc5JuwgqxyA5fGMBnsgXmehT2jmIByCxIc8RdP1L7nq1zmp0bM4LBm430Yc+IvRNK
         Y6kGHFoq447UrFGYjkj5BsCN4ryglX/7dew5yWXWd08svoDolyobh5kT94sFjsquyLk5
         abk92K0I3GSERFdQchZH6ikJ8Re9vphbXgdW52sy/n5DRE6WdBK5Hf/N4A/j7g1W9tOs
         P2yg==
X-Forwarded-Encrypted: i=1; AFNElJ/ZPynnri2VizY654jgwrdIPNj2Rw9IAqYE5aKwfLtDMAdDGtBKBDgeKyFzRedDjpn5jF9Vg8Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyj31n21tah4JNHo5GwlNJHrt7oCvaILG3V3Gk+EOXD6rYY1JQP
	+Jmn8yCahQTcyGtvyyvICtZbJXyXEPOmrD/EmXxX75he0DoPcGz/bMRNYyizwPpHECmW9jN4Sc5
	v648BYEuzwrq7OlgjQQQWzmODPLu0cpo=
X-Gm-Gg: Acq92OGcIEYWRpgbJsO6w769anfEzRxiZF97411fnjIbC/QM2eD7E7dRK6WMsvBjdpx
	54za190cekuj2vFPqWXBcxe+GC8cAgpFDp5PhhukopfOC888NpmmbIMDcffTMXZaeRmOzn6NjOJ
	rPJHAcg90wLC4WGb1uvcV/0Ahq/dQZPRj9z7w7NHh6+uHbiFZWZewKXXvwJPTbfpwsM4MggXwjp
	C06nPvTQyA4osWHLxAdro+vFl8JyqAjmgfVvinGVLW/4i6cg+mgI+ZKtxrRw4xjDUkYPOBLDlEK
	+3PZoOUR
X-Received: by 2002:a17:90b:2743:b0:368:b176:c5a8 with SMTP id
 98e67ed59e1d1-36951b76e8emr25519894a91.15.1779293122447; Wed, 20 May 2026
 09:05:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260518143233.16091-1-capyenglishlite@gmail.com>
 <20260519212328.GA2614626@google.com> <CAEABq7f3agKZqrBiu+UwXHY44mTcK360ryg-i0w=wEc_Lv+T0A@mail.gmail.com>
 <CABCJKuej82rrQbQ0eoG+JsY6Fwi0SdVJqduvps7eiPrJ_BgT0A@mail.gmail.com>
In-Reply-To: <CABCJKuej82rrQbQ0eoG+JsY6Fwi0SdVJqduvps7eiPrJ_BgT0A@mail.gmail.com>
From: Afi0 <capyenglishlite@gmail.com>
Date: Wed, 20 May 2026 16:05:11 +0000
X-Gm-Features: AVHnY4J5glQyuMNUB5RUhyTem7wt8BMGLrDPa6lowox8AMJ-hYVnXdOWy6oyHOc
Message-ID: <CAEABq7e5NT0c58gG=fqFK-RmfrgUDA-8jXnmMMQZHMNu4hea5Q@mail.gmail.com>
Subject: Re: [PATCH v2] module: decompress: check return value of module_extend_max_pages()
To: Sami Tolvanen <samitolvanen@google.com>
Cc: linux-modules@vger.kernel.org, chleroy@kernel.org, mcgrof@kernel.org, 
	dmitry.torokhov@gmail.com, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: multipart/mixed; boundary="00000000000084c5b4065241f693"
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,multipart/alternative,text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-250024-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,gmail.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:+,3:~,4:~];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[capyenglishlite@gmail.com,stable@vger.kernel.org];
	HAS_ATTACHMENT(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	FREEMAIL_FROM(0.00)[gmail.com];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Queue-Id: A1693592D07
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

--00000000000084c5b4065241f693
Content-Type: multipart/alternative; boundary="00000000000084c5b3065241f691"

--00000000000084c5b3065241f691
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

  Thanks for the correction. Updated commit message

On Wed, May 20, 2026 at 3:13=E2=80=AFPM Sami Tolvanen <samitolvanen@google.=
com>
wrote:

> On Tue, May 19, 2026 at 9:11=E2=80=AFPM Afi0 <capyenglishlite@gmail.com> =
wrote:
> >
> > Hi,
> >
> > You are right, the commit message overstates the impact. The actual
> result is an immediate kernel oops, not an OOB write into adjacent slab
> objects. The fix is still correct - checking the return value avoids the
> oops. Shall I send a v3 with a corrected commit message?
>
> Yes, please send v3.
>
> Sami
>

--00000000000084c5b3065241f691
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">=C2=A0 Thanks for the correction. Updated commit message=
=C2=A0</div><br><div class=3D"gmail_quote gmail_quote_container"><div dir=
=3D"ltr" class=3D"gmail_attr">On Wed, May 20, 2026 at 3:13=E2=80=AFPM Sami =
Tolvanen &lt;<a href=3D"mailto:samitolvanen@google.com">samitolvanen@google=
.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"mar=
gin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1=
ex">On Tue, May 19, 2026 at 9:11=E2=80=AFPM Afi0 &lt;<a href=3D"mailto:capy=
englishlite@gmail.com" target=3D"_blank">capyenglishlite@gmail.com</a>&gt; =
wrote:<br>
&gt;<br>
&gt; Hi,<br>
&gt;<br>
&gt; You are right, the commit message overstates the impact. The actual re=
sult is an immediate kernel oops, not an OOB write into adjacent slab objec=
ts. The fix is still correct - checking the return value avoids the oops. S=
hall I send a v3 with a corrected commit message?<br>
<br>
Yes, please send v3.<br>
<br>
Sami<br>
</blockquote></div>

--00000000000084c5b3065241f691--
--00000000000084c5b4065241f693
Content-Type: application/octet-stream; 
	name=0003-module-decompress-check-return-value-of-module_extend_max_pages-v3
Content-Disposition: attachment; 
	filename=0003-module-decompress-check-return-value-of-module_extend_max_pages-v3
Content-Transfer-Encoding: base64
Content-ID: <f_mpe94zgz0>
X-Attachment-Id: f_mpe94zgz0

RnJvbSBjNGQ1ZTZmN2E4YjljNGQ1ZTZmN2E4YjljNGQ1ZTZmN2E4YjljNGQ1IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbmRyaWkgS3VjaG1lbmtvIDxjYXB5ZW5nbGlzaGxpdGVAZ21h
aWwuY29tPgpEYXRlOiBTYXQsIDE2IE1heSAyMDI2IDEzOjA4OjAwICswMDAwClN1YmplY3Q6IFtQ
QVRDSCB2M10gbW9kdWxlOiBkZWNvbXByZXNzOiBjaGVjayByZXR1cm4gdmFsdWUgb2YKIG1vZHVs
ZV9leHRlbmRfbWF4X3BhZ2VzKCkKCm1vZHVsZV9leHRlbmRfbWF4X3BhZ2VzKCkgY2FsbHMga3Zy
ZWFsbG9jKCkgaW50ZXJuYWxseSBhbmQgcmV0dXJucwotRU5PTUVNIG9uIGFsbG9jYXRpb24gZmFp
bHVyZS4gVGhlIHJldHVybiB2YWx1ZSBpcyBuZXZlciBjaGVja2VkLgoKSWYgdGhlIGFsbG9jYXRp
b24gZmFpbHMsIGluZm8tPnBhZ2VzIGlzIGxlZnQgcG9pbnRpbmcgdG8gZnJlZWQgbWVtb3J5CmFu
ZCBzdWJzZXF1ZW50IGNhbGxzIHRvIG1vZHVsZV9nZXRfbmV4dF9wYWdlKCkgd2lsbCBhdHRlbXB0
IHRvIHdyaXRlCnN0cnVjdCBwYWdlIHBvaW50ZXJzIHRocm91Z2ggdGhlIHN0YWxlIHBvaW50ZXIs
IHJlc3VsdGluZyBpbiBhIGtlcm5lbApvb3BzLgoKRml4OiBhZGQgdGhlIG1pc3NpbmcgZXJyb3Ig
Y2hlY2sgYWZ0ZXIgbW9kdWxlX2V4dGVuZF9tYXhfcGFnZXMoKSBhbmQKcmV0dXJuIGltbWVkaWF0
ZWx5IG9uIGZhaWx1cmUuIFRoaXMgbWF0Y2hlcyB0aGUgcGF0dGVybiB1c2VkIGJ5IGV2ZXJ5Cm90
aGVyIGt2cmVhbGxvYygpIGNhbGxlciBpbiB0aGUgbW9kdWxlIGxvYWRpbmcgcGF0aC4KCkZpeGVz
OiAxNjlhNThhZDgyNGQgKCJtb2R1bGU6IGFkZCBpbi1rZXJuZWwgc3VwcG9ydCBmb3IgZGVjb21w
cmVzc2luZyIpCkNjOiBEbWl0cnkgVG9yb2tob3YgPGRtaXRyeS50b3Jva2hvdkBnbWFpbC5jb20+
CkNjOiBMdWlzIENoYW1iZXJsYWluIDxtY2dyb2ZAa2VybmVsLm9yZz4KQ2M6IHN0YWJsZUB2Z2Vy
Lmtlcm5lbC5vcmcKU2lnbmVkLW9mZi1ieTogQW5kcmlpIEt1Y2htZW5rbyA8Y2FweWVuZ2xpc2hs
aXRlQGdtYWlsLmNvbT4KLS0tCkNoYW5nZXMgaW4gdjM6CiAtIENvcnJlY3QgY29tbWl0IG1lc3Nh
Z2U6IGFjdHVhbCBpbXBhY3QgaXMgYSBrZXJuZWwgb29wcywgbm90IGFuCiAgIE9PQiB3cml0ZSBp
bnRvIGFkamFjZW50IHNsYWIgb2JqZWN0cyAoU2FtaSBUb2x2YW5lbikKCkNoYW5nZXMgaW4gdjI6
CiAtIFJlbW92ZSB1bm5lY2Vzc2FyeSBpbml0aWFsaXphdGlvbiBvZiAnZXJyb3InIHRvIDAgKENo
cmlzdG9waGUgTGVyb3kpCiAtIFJlbW92ZSB1bnJlbGF0ZWQgYmxhbmsgbGluZSBhZnRlciBpZiAo
ZXJyb3IpIHJldHVybiBlcnJvciAoQ2hyaXN0b3BoZSBMZXJveSkKCiBrZXJuZWwvbW9kdWxlL2Rl
Y29tcHJlc3MuYyB8IDMgKysrCiAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspCgpkaWZm
IC0tZ2l0IGEva2VybmVsL21vZHVsZS9kZWNvbXByZXNzLmMgYi9rZXJuZWwvbW9kdWxlL2RlY29t
cHJlc3MuYwotLS0gYS9rZXJuZWwvbW9kdWxlL2RlY29tcHJlc3MuYworKysgYi9rZXJuZWwvbW9k
dWxlL2RlY29tcHJlc3MuYwpAQCAtWFhYLDkgK1hYWCwxMiBAQCBpbnQgbW9kdWxlX2RlY29tcHJl
c3Moc3RydWN0IGxvYWRfaW5mbyAqaW5mbywKIAkJCQljb25zdCB2b2lkICpidWYsIHNpemVfdCBz
aXplKQogewogCXVuc2lnbmVkIGludCBuX3BhZ2VzOwogCWludCBlcnJvcjsKIAlzc2l6ZV90IGRh
dGFfc2l6ZTsKCiAJbl9wYWdlcyA9IERJVl9ST1VORF9VUChzaXplLCBQQUdFX1NJWkUpICogMjsK
IAllcnJvciA9IG1vZHVsZV9leHRlbmRfbWF4X3BhZ2VzKGluZm8sIG5fcGFnZXMpOworCWlmIChl
cnJvcikKKwkJcmV0dXJuIGVycm9yOwogCWRhdGFfc2l6ZSA9IE1PRFVMRV9ERUNPTVBSRVNTX0ZO
KGluZm8sIGJ1Ziwgc2l6ZSk7CiAJaWYgKGRhdGFfc2l6ZSA8IDApIHsKIAkJZXJyb3IgPSBkYXRh
X3NpemU7Ci0tCjIuMzkuMAo=
--00000000000084c5b4065241f693--

