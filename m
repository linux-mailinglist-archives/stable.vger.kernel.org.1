Return-Path: <stable+bounces-45265-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 81DEC8C7474
	for <lists+stable@lfdr.de>; Thu, 16 May 2024 12:14:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36208281BC6
	for <lists+stable@lfdr.de>; Thu, 16 May 2024 10:14:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7ACF143890;
	Thu, 16 May 2024 10:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=onmail.com header.i=@onmail.com header.b="CFMxSuYs"
X-Original-To: stable@vger.kernel.org
Received: from mail-ue1-f04.onmail.com (mail-ue1-f04.onmail.com [3.212.134.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8CCE14387F
	for <stable@vger.kernel.org>; Thu, 16 May 2024 10:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=3.212.134.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715854344; cv=none; b=nNo295cZnhkghq9mYTwSyIEV+DuguuZhyNI8dEERgWO8cBjlv+9+CEA2XPePP+nn/xn4OaPcL55OjmFKV8qCqSvQzykFXonihMj5se4/SZHPUFQweH1UQtC5pbxKHzS1ljpNzqqWuEffC5mL8vQF7mifQxAg7v9QGmtIpKU68SY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715854344; c=relaxed/simple;
	bh=IuZ9l2raF4lKepfElqAwYqXiYFHk14kFBc/sJRJVIVM=;
	h=Cc:Content-Type:Date:From:MIME-Version:Message-ID:Subject:To; b=Gtc6Ae3ben2QKVXBsaw6+P2Qi5PPpdhRwr/90ZYMFK2kFm4D+4K0RjCbrB6VgYRFq8ixcqsggXC6o4P8SyIJaP5H/+XneBghyo6WPE9aWnARGklyent0yDQUWkqvfHWZ/32wKG+xHscYnJm40v4Kipiq3YFqVLtUUMdp22RS7fM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=onmail.com; spf=pass smtp.mailfrom=onmail.com; dkim=pass (2048-bit key) header.d=onmail.com header.i=@onmail.com header.b=CFMxSuYs; arc=none smtp.client-ip=3.212.134.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=onmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onmail.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=mail; d=onmail.com; h=mime-version:date:from:subject:to:message-id:
 cc; bh=RbIaxq8l6cDJnsrGA0fQMu7nUQVogB/mUbc4QwoUWSU=;
 b=CFMxSuYsdF7WLaJZMWu/IonTLqwZ0Y0tiN5mGcxyX7JKpNoppSsbpBH6QGw3yQRyRzFGe4
 4m81LKXPtdu3nqak2NDgE7SjIzWfrtNB37CGKVBV1y23ydp6CZW8VYvdv0iaN/4vj6giI+
 UosGmCJlYn3JkMMcRyv8yXQUB9XEkc6Flvlu3lKX9JCP05B3CqpyE5cy2JSIgxmiZ7HFu6
 9OpThPiVTgKck9vWesTtU9c4i7X7V0JwP5ATzAHg4gOqdEM9q/QGJBqMt4V7N7qoSAzHY9
 s0a174t/aLliyohTf9O1vDnQ7U1Y8AFRmpHmxek6UOyJkX7mbvCNS4UuaIMY6A==
Cc: "regressions@lists.linux.dev" <regressions@lists.linux.dev>
Content-Type: multipart/mixed; boundary=0000000000000015c9846566491bb9
Date: Thu, 16 May 2024 02:19:15 -0700
From: "Alexander Sergeev" <alexander.sergeev@onmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <ac768f81f5218be629864b850bb7b959-1715851155@onmail.com>
Subject: Rtnetlink GETADDR request for 1 specific interface only (by ID)
To: "stable@vger.kernel.org" <stable@vger.kernel.org>
X-Em-Message-ID: GkdgwIatAk1bSN0juz27GYtGV2e3bxCrwd+8MwFMBsQ=

--0000000000000015c9846566491bb9
Content-Type: multipart/alternative;
	boundary=000000000000003fc3b01e13bae54f

--000000000000003fc3b01e13bae54f
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=utf-8

Good morning!

Recently, I have found an issue with `rtnetlink` library that seems to be n=
ot intended and/or documented. I have asked about it several times, includi=
ng here and it was also reported here. Neither in related RFC document nor =
in rtnetlink manuals the issue is described or mentioned.

In a few words, the issue is: for some reason, rtnetlink GETADDR request wo=
rks only with NLM_F_ROOT or NLM_F_DUMP flags. Consequently, for instance, f=
iltering by ifa_index field, that would *theoretically* according to docs, =
allow us to receive address info for 1 specific interface only (by ID) , is=
 not possible. For comparison, similar functionality to GETLINK request (ge=
tting information about exactly 1 link by index) is indeed very possible. I=
nstead of the expected output (information about 1 interface only), what is=
 returned is an error message with errno -95, which, as I suppose, can be r=
ead as "operation not permitted".

To this email, I attach a small C file illustrating my issue. Feel free to =
change IFACE_ID define for ID of any network interface present in your syst=
em. It illustrates the error.

Please, let me know what you think about this issue. Am I missing something=
 or does it really needs fixing or at least documenting?
Best regards,
Aleksandr Sergeev.

P.S. I have been told that this issue probably won't be addressed, because =
it "can easily be fixed in user space", however I believe in Linux kernel m=
aintainers team dedication for clear, well-documented and bug-free code; so=
 if this issue is not hard to fix, I would suggest addressing it at least i=
n docs. If it can be useful, I would be more than grateful to provide my he=
lp with it.
--000000000000003fc3b01e13bae54f
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html; charset=utf-8

<div>Good morning!</div>
<div><br></div>
<div>Recently, I have found an issue with `rtnetlink` library that seems to=
 be not intended and/or documented. I have asked about it several times, in=
cluding <a href=3D"https://www.linuxquestions.org/questions/linux-networkin=
g-3/how-to-use-rtnetlink-getaddr-query-to-retrieve-a-%2A%2Asingle%2A%2A-add=
ress-information-4175736659/" target=3D"_blank" rel=3D"noopener noreferrer"=
>here</a> and it was also reported <a href=3D"https://stackoverflow.com/que=
stions/71947088/linux-c-rtnetlink-rtm-getaddr-ignores-ifa-index-in-struct-i=
faddrmsg-and-instead" target=3D"_blank" rel=3D"noopener noreferrer">here</a=
>. Neither in <a href=3D"https://www.rfc-editor.org/rfc/rfc3549">related RF=
C document</a> nor in <a href=3D"https://man7.org/linux/man-pages/man7/rtne=
tlink.7.html">rtnetlink manuals</a> the issue is described or mentioned.</d=
iv>
<div><br></div>
<div>In a few words, the issue is: for some reason, rtnetlink GETADDR reque=
st works only with NLM_F_ROOT or NLM_F_DUMP flags. Consequently, for instan=
ce, filtering by ifa_index field, that would *theoretically* according to d=
ocs, allow us to receive address info for 1 specific interface only (by ID)=
 , is not possible. For comparison, similar functionality to GETLINK reques=
t (getting information about exactly 1 link by index) is indeed very possib=
le. Instead of the expected output (information about 1 interface only), wh=
at is returned is an error message with errno -95, which, as I suppose, can=
 be read as "operation not permitted".</div>
<div><br></div>
<div>To this email, I attach a small C file illustrating my issue. Feel fre=
e to change IFACE_ID define for ID of any network interface present in your=
 system. It illustrates the error.</div>
<div><br></div>
<div>Please, let me know what you think about this issue. Am I missing some=
thing or does it really needs fixing or at least documenting?</div>
<div class=3D"webmail_signature">
<div>Best regards,</div>
<div>Aleksandr Sergeev.</div>
<div><br></div>
<div>P.S. I have been told that this issue probably won't be addressed, bec=
ause it "can easily be fixed in user space", however I believe in Linux ker=
nel maintainers team dedication for clear, well-documented and bug-free cod=
e; so if this issue is not hard to fix, I would suggest addressing it at le=
ast in docs. If it can be useful, I would be more than grateful to provide =
my help with it.</div>
</div>
--000000000000003fc3b01e13bae54f--

--0000000000000015c9846566491bb9
Content-Disposition: attachment; filename=main.c
Content-Id: <fbe9b27bac7a4526a498689ffc1f0f5b>
Content-Transfer-Encoding: base64
Content-Type: application/octet-stream

I2luY2x1ZGUgPHN0ZGlvLmg+CiNpbmNsdWRlIDxzdGRsaWIuaD4KI2luY2x1ZGUgPGxpbnV4L2lu
cHV0Lmg+CiNpbmNsdWRlIDxsaW51eC9uZXRsaW5rLmg+CiNpbmNsdWRlIDxsaW51eC9ydG5ldGxp
bmsuaD4KI2luY2x1ZGUgPGxpbnV4L2lmX2FkZHIuaD4KI2luY2x1ZGUgPHN5cy9zb2NrZXQuaD4K
I2luY2x1ZGUgPHVuaXN0ZC5oPgojaW5jbHVkZSA8c3RyaW5nLmg+CiNpbmNsdWRlIDxlcnJuby5o
PgoKI2RlZmluZSBJRkFDRV9JRCAzCiNkZWZpbmUgREFUQV9MRU5HVEggMzI3NjgKCnN0cnVjdCBw
YWNrZXQgewogICAgc3RydWN0IG5sbXNnaGRyIGhkcjsKICAgIHN0cnVjdCBpZmFkZHJtc2cgbXNn
Owp9OwoKCnZvaWQgZ2VuZXJhdGVfYWRkcmVzc19yZXF1ZXN0KHN0cnVjdCBwYWNrZXQqIHBhY2ss
IGludCBpbnRlcmZhY2VfaWQpIHsKICAgIG1lbXNldChwYWNrLCAwLCBzaXplb2Yoc3RydWN0IHBh
Y2tldCkpOwogICAgcGFjay0+aGRyLm5sbXNnX2xlbiA9IHNpemVvZihzdHJ1Y3QgcGFja2V0KTsK
ICAgIHBhY2stPmhkci5ubG1zZ190eXBlID0gUlRNX0dFVEFERFI7CiAgICBwYWNrLT5oZHIubmxt
c2dfZmxhZ3MgPSBOTE1fRl9SRVFVRVNUOwogICAgcGFjay0+bXNnLmlmYV9pbmRleCA9IGludGVy
ZmFjZV9pZDsgIC8vIFRoaXMgZ2V0cyBpZ25vcmVkLCB3aHk/Cn0KCnZvaWQgcGFyc2VfYWxsX3Bh
Y2tldHMoY2hhciogbWVzc2FnZXNfYnl0ZXMsIGludCB0b3RhbF9sZW5ndGgpIHsKICAgIGludCBp
bmRleCA9IDAsIGN1cnNvciA9IDA7CiAgICB3aGlsZSAoY3Vyc29yIDwgdG90YWxfbGVuZ3RoKSB7
CiAgICAgICAgc3RydWN0IG5sbXNnaGRyKiBoZWFkZXIgPSAoc3RydWN0IG5sbXNnaGRyKikgKG1l
c3NhZ2VzX2J5dGVzICsgY3Vyc29yKTsKICAgICAgICBpZiAoaGVhZGVyLT5ubG1zZ190eXBlID09
IE5MTVNHX0VSUk9SKSB7CiAgICAgICAgICAgIGludCogZXJybnVtYmVyID0gKGludCopIChtZXNz
YWdlc19ieXRlcyArIGN1cnNvciArIHNpemVvZihzdHJ1Y3Qgbmxtc2doZHIpKTsKICAgICAgICAg
ICAgcHJpbnRmKCJDb3VsZG4ndCBwYXJzZSBtZXNzYWdlICMlZCwgZXJybm86ICVkIVxuIiwgaW5k
ZXgsICplcnJudW1iZXIpOwogICAgICAgIH0gZWxzZSBpZiAoaGVhZGVyLT5ubG1zZ190eXBlID09
IE5MTVNHX0RPTkUpIHsKICAgICAgICAgICAgcHJpbnRmKCJNZXNzYWdlICMlZCwgd2FzIHRoZSBs
YXN0IG9uZSFcbiIsIGluZGV4KTsKICAgICAgICAgICAgY29udGludWU7CiAgICAgICAgfSBlbHNl
IHsKICAgICAgICAgICAgc3RydWN0IGlmYWRkcm1zZyogbWVzc2FnZSA9IChzdHJ1Y3QgaWZhZGRy
bXNnKikgKG1lc3NhZ2VzX2J5dGVzICsgY3Vyc29yICsgc2l6ZW9mKHN0cnVjdCBubG1zZ2hkcikp
OwogICAgICAgICAgICBwcmludGYoIk1lc3NhZ2UgIyVkIGNvbnRhaW5zIGludGVyZmFjZSAjJWQg
ZGF0YSwgZS5nLiBwcmVmaXhsZW46ICVkIVxuIiwgaW5kZXgsIG1lc3NhZ2UtPmlmYV9pbmRleCwg
bWVzc2FnZS0+aWZhX3ByZWZpeGxlbik7CiAgICAgICAgfQogICAgICAgIGN1cnNvciArPSBoZWFk
ZXItPm5sbXNnX2xlbjsKICAgICAgICBpbmRleCsrOwogICAgfQp9CgppbnQgbWFpbigpIHsKICAg
IHN0cnVjdCBzb2NrYWRkcl9ubCBhZGRyOwogICAgbWVtc2V0KCZhZGRyLCAwLCBzaXplb2Yoc3Ry
dWN0IHNvY2thZGRyX25sKSk7CiAgICBhZGRyLm5sX2ZhbWlseSA9IEFGX05FVExJTks7CgogICAg
aW50IHNvY2sgPSBzb2NrZXQoQUZfTkVUTElOSywgU09DS19SQVcsIE5FVExJTktfUk9VVEUpOwog
ICAgaWYgKHNvY2sgPT0gLTEpIHsKICAgICAgICBwcmludGYoIkNvdWxkbid0IGNyZWF0ZSBuZXRs
aW5rIHNvY2tldCwgZXJybm86ICVkIVxuIiwgZXJybm8pOwogICAgICAgIGV4aXQoMSk7CiAgICB9
CgogICAgaW50IGVyciA9IGJpbmQoc29jaywgKHN0cnVjdCBzb2NrYWRkciAqKSAmYWRkciwgc2l6
ZW9mKHN0cnVjdCBzb2NrYWRkcl9ubCkpOwogICAgaWYgKGVyciAhPSAwKSB7CiAgICAgICAgcHJp
bnRmKCJDb3VsZG4ndCBiaW5kIG5ldGxpbmsgc29ja2V0LCBlcnJubzogJWQhXG4iLCBlcnJubyk7
CiAgICAgICAgZXhpdCgxKTsKICAgIH0KCiAgICBzb2NrbGVuX3QgbGVuID0gIHNpemVvZihzdHJ1
Y3Qgc29ja2FkZHJfbmwpOwogICAgZ2V0c29ja25hbWUoc29jaywgKHN0cnVjdCBzb2NrYWRkciAq
KSAmYWRkciwgJmxlbik7CgogICAgc3RydWN0IHBhY2tldCBwYWNrOwogICAgZ2VuZXJhdGVfYWRk
cmVzc19yZXF1ZXN0KCZwYWNrLCBJRkFDRV9JRCk7CiAgICB3cml0ZShzb2NrLCAmcGFjaywgc2l6
ZW9mKHN0cnVjdCBwYWNrZXQpKTsKCiAgICBjaGFyIGJ1ZltEQVRBX0xFTkdUSF07CiAgICBtZW1z
ZXQoYnVmLCAwLCBEQVRBX0xFTkdUSCk7CiAgICBpbnQgcmVzcG9uc2VfbGVuID0gcmVhZChzb2Nr
LCBidWYsIChzb2NrbGVuX3QpIERBVEFfTEVOR1RIKTsKICAgIHBhcnNlX2FsbF9wYWNrZXRzKGJ1
ZiwgcmVzcG9uc2VfbGVuKTsKfQo=

--0000000000000015c9846566491bb9--

